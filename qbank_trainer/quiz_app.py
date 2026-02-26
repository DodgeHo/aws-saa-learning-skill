import json
import logging
import os
import random
import sqlite3
import threading
from pathlib import Path
from tkinter import (
    END,
    LEFT,
    RIGHT,
    BOTH,
    X,
    Y,
    Menu,
    StringVar,
    BooleanVar,
    Tk,
    Toplevel,
)
from tkinter import filedialog, messagebox
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText

import requests

# simple logging to console for debugging
logging.basicConfig(level=logging.INFO)

APP_DIR = Path(os.getenv("APPDATA", str(Path.home()))) / "aws-saa-trainer"
CONFIG_PATH = APP_DIR / "config.json"


def load_env_key() -> str:
    env_path = Path(__file__).parent / ".env"
    if not env_path.exists():
        return ""
    try:
        for raw_line in env_path.read_text(encoding="utf-8").splitlines():
            line = raw_line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            if key.strip() == "DEEPSEEK_API_KEY":
                return value.strip().strip('"').strip("'")
    except Exception:
        return ""
    return ""


def load_config() -> dict:
    if CONFIG_PATH.exists():
        try:
            return json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
        except Exception:
            return {}
    return {}


def save_config(config: dict) -> None:
    APP_DIR.mkdir(parents=True, exist_ok=True)
    CONFIG_PATH.write_text(json.dumps(config, ensure_ascii=False, indent=2), encoding="utf-8")


class QBankApp:
    def __init__(self, root: Tk) -> None:
        self.root = root
        self.root.title("AWS-SAA 背题助手 (MVP)")
        self.root.geometry("1300x800")

        self.config = load_config()
        self.db_path = self.config.get("last_opened_db", "")
        self.api_key = load_env_key() or os.getenv("DEEPSEEK_API_KEY") or self.config.get("deepseek_api_key", "")

        self.conn: sqlite3.Connection | None = None
        # maintain full and filtered question lists
        self.all_questions: list[dict] = []
        self.questions: list[dict] = []
        self.current_index = 0

        # remember filter/random state across sessions
        self.filter_mode = self.config.get("filter_mode", "All")
        self.random_order = self.config.get("random_order", False)

        # ui-bound variables
        self.top_info = StringVar(value="未加载题库")
        self.status_info = StringVar(value="状态：未标记")
        self.filter_var = StringVar(value=self.filter_mode)
        self.random_var = BooleanVar(value=self.random_order)
        self.jump_var = StringVar()
        self.progress_var = StringVar(value="进度: 0/0")

        self._build_ui()
        self._open_db_on_startup()

    def _build_ui(self) -> None:
        toolbar = ttk.Frame(self.root)
        toolbar.pack(fill=X, padx=8, pady=8)

        ttk.Button(toolbar, text="打开数据库", command=self.open_db).pack(side=LEFT, padx=4)
        ttk.Button(toolbar, text="设置 DeepSeek Key", command=self.open_settings).pack(side=LEFT, padx=4)
        ttk.Button(toolbar, text="上一题", command=self.prev_question).pack(side=LEFT, padx=12)
        ttk.Button(toolbar, text="下一题", command=self.next_question).pack(side=LEFT, padx=4)

        # filtering controls
        ttk.Label(toolbar, text="过滤:").pack(side=LEFT, padx=(12,2))
        cb = ttk.Combobox(
            toolbar,
            textvariable=self.filter_var,
            values=["All", "Know", "DontKnow", "Favorite"],
            state="readonly",
            width=10,
        )
        cb.pack(side=LEFT, padx=2)
        ttk.Button(toolbar, text="应用", command=self.apply_filter).pack(side=LEFT, padx=2)
        ttk.Button(toolbar, text="清除", command=self.clear_filter).pack(side=LEFT, padx=2)

        # random toggle
        ttk.Checkbutton(
            toolbar, text="随机", variable=self.random_var, command=self.toggle_random
        ).pack(side=LEFT, padx=4)

        # jump to question
        ttk.Entry(toolbar, textvariable=self.jump_var, width=5).pack(side=LEFT, padx=4)
        ttk.Button(toolbar, text="跳转", command=self.go_to_question).pack(side=LEFT, padx=2)

        ttk.Label(toolbar, textvariable=self.progress_var).pack(side=RIGHT, padx=4)
        ttk.Label(toolbar, textvariable=self.top_info).pack(side=RIGHT)

        body = ttk.Panedwindow(self.root, orient="horizontal")
        body.pack(fill=BOTH, expand=True, padx=8, pady=8)

        left = ttk.Frame(body)
        right = ttk.Frame(body)
        body.add(left, weight=3)
        body.add(right, weight=2)

        status_bar = ttk.Frame(left)
        status_bar.pack(fill=X, pady=(0, 6))
        ttk.Label(status_bar, textvariable=self.status_info).pack(side=LEFT)
        ttk.Button(status_bar, text="会", command=lambda: self.mark_status("Know")).pack(side=RIGHT, padx=3)
        ttk.Button(status_bar, text="不会", command=lambda: self.mark_status("DontKnow")).pack(side=RIGHT, padx=3)
        ttk.Button(status_bar, text="收藏", command=lambda: self.mark_status("Favorite")).pack(side=RIGHT, padx=3)

        self.question_text = ScrolledText(left, wrap="word", font=("Microsoft YaHei UI", 11))
        self.question_text.pack(fill=BOTH, expand=True)

        answer_wrap = ttk.Frame(left)
        answer_wrap.pack(fill=X, pady=(6, 0))
        answer_label = ttk.Label(answer_wrap, text="答案与解析")
        answer_label.pack(side=LEFT)
        ttk.Button(answer_wrap, text="显示答案/解析", command=self.show_answer).pack(side=RIGHT)
        self.answer_text = ScrolledText(left, wrap="word", height=10, font=("Microsoft YaHei UI", 10))
        self.answer_text.pack(fill=BOTH, expand=False)

        ttk.Label(right, text="AI 辅助提问（DeepSeek）", font=("Microsoft YaHei UI", 11, "bold")).pack(anchor="w")

        ttk.Button(
            right,
            text="这题用到了什么知识？",
            command=lambda: self.ask_ai("请总结这道题涉及的 AWS-SAA 核心知识点，按 3-5 条列出。"),
        ).pack(fill=X, pady=4)

        ttk.Button(
            right,
            text="这道题是什么意思？",
            command=lambda: self.ask_ai("请用通俗中文解释这道题在问什么，并指出关键词。"),
        ).pack(fill=X, pady=4)

        ttk.Button(
            right,
            text="为什么是这个结果？",
            command=lambda: self.ask_ai("请解释为什么该答案正确，并说明其他选项为什么不正确。"),
        ).pack(fill=X, pady=4)

        ttk.Button(
            right,
            text="我没看懂，能更简单吗？",
            command=lambda: self.ask_ai("请用更简单、面向初学者的方式重讲，并给一个生活类比。"),
        ).pack(fill=X, pady=4)

        custom_wrap = ttk.Frame(right)
        custom_wrap.pack(fill=X, pady=8)
        ttk.Label(custom_wrap, text="自定义提问").pack(anchor="w")
        self.custom_entry = ttk.Entry(custom_wrap)
        self.custom_entry.pack(fill=X, pady=4)
        ttk.Button(custom_wrap, text="发送自定义问题", command=self.ask_ai_custom).pack(fill=X)

        ai_top = ttk.Frame(right)
        ai_top.pack(fill=X, pady=(8, 0))
        ttk.Label(ai_top, text="AI 输出").pack(side=LEFT)
        ttk.Button(ai_top, text="清空历史", command=self.clear_ai_history).pack(side=RIGHT)
        self.ai_text = ScrolledText(right, wrap="word", font=("Microsoft YaHei UI", 10))
        self.ai_text.pack(fill=BOTH, expand=True)
        self._setup_ai_context_menu()

    def _open_db_on_startup(self) -> None:
        if self.db_path and Path(self.db_path).exists():
            self._connect_and_load(self.db_path)
        else:
            default_db = Path(__file__).parent / "data.db"
            if default_db.exists():
                self._connect_and_load(str(default_db))

    def open_db(self) -> None:
        file_path = filedialog.askopenfilename(
            title="选择 SQLite 数据库",
            filetypes=[("SQLite DB", "*.db"), ("All Files", "*.*")],
        )
        if not file_path:
            return
        self._connect_and_load(file_path)

    def _connect_and_load(self, db_path: str) -> None:
        try:
            if self.conn:
                self.conn.close()
            self.conn = sqlite3.connect(db_path)
            self.conn.row_factory = sqlite3.Row
            self._ensure_runtime_tables()
            cur = self.conn.cursor()
            # load the full set of questions and keep a master copy
            self.all_questions = [
                dict(row)
                for row in cur.execute(
                    "SELECT * FROM questions ORDER BY CAST(q_num AS INTEGER), id"
                ).fetchall()
            ]
            self.questions = list(self.all_questions)

            self.db_path = db_path
            self.config["last_opened_db"] = db_path
            save_config(self.config)

            if not self.questions:
                messagebox.showwarning("提示", "数据库中没有 questions 数据。")
                return

            # apply saved options
            if self.random_order:
                random.shuffle(self.questions)
            if self.filter_mode != "All":
                self.apply_filter()

            stored = self.config.get("last_index", {})
            last_idx = stored.get(db_path, 0)
            if 0 <= last_idx < len(self.questions):
                self.current_index = last_idx
            else:
                self.current_index = 0

            self.render_question()
        except Exception as exc:
            messagebox.showerror("打开数据库失败", str(exc))
            logging.exception("failed to open database")

    def _ensure_runtime_tables(self) -> None:
        if not self.conn:
            return
        cur = self.conn.cursor()
        cur.execute(
            """
            CREATE TABLE IF NOT EXISTS user_status (
                question_id INTEGER,
                status TEXT,
                updated_at TEXT
            )
            """
        )
        cur.execute(
            """
            CREATE TABLE IF NOT EXISTS import_jobs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source_doc TEXT,
                created_at TEXT,
                notes TEXT
            )
            """
        )
        self.conn.commit()

    def get_current(self) -> dict | None:
        if not self.questions:
            return None
        if self.current_index < 0 or self.current_index >= len(self.questions):
            return None
        return self.questions[self.current_index]

    def render_question(self) -> None:
        question = self.get_current()
        if not question:
            self.top_info.set("未加载题目")
            return

        idx = self.current_index + 1
        total = len(self.questions)
        self.top_info.set(f"第 {idx}/{total} 题 | q_num={question.get('q_num')}")

        status = self.get_status(question["id"])
        self.status_info.set(f"状态：{status if status else '未标记'}")

        # update and persist progress
        self.update_progress_info()
        self.save_progress()

        options_zh = self._safe_json_list(question.get("options_zh"))
        options_en = self._safe_json_list(question.get("options_en"))

        parts = [
            f"【中文题干】\n{question.get('stem_zh') or '(空)'}",
            "\n【中文选项】\n" + ("\n".join(options_zh) if options_zh else "(空)"),
            f"\n\n【English Stem】\n{question.get('stem_en') or '(empty)'}",
            "\n【English Options】\n" + ("\n".join(options_en) if options_en else "(empty)"),
        ]

        self.question_text.delete("1.0", END)
        self.question_text.insert("1.0", "\n".join(parts))

        self.answer_text.delete("1.0", END)

    @staticmethod
    def _safe_json_list(raw: str | None) -> list[str]:
        if not raw:
            return []
        try:
            value = json.loads(raw)
            return value if isinstance(value, list) else []
        except Exception:
            return []

    def prev_question(self) -> None:
        if self.current_index > 0:
            self.current_index -= 1
            self.render_question()

    def next_question(self) -> None:
        if self.current_index < len(self.questions) - 1:
            self.current_index += 1
            self.render_question()

    def show_answer(self) -> None:
        question = self.get_current()
        if not question:
            return
        text = (
            f"正确答案：{question.get('correct_answer') or '(空)'}\n\n"
            f"中文解析：\n{question.get('explanation_zh') or '(空)'}\n\n"
            f"English Explanation:\n{question.get('explanation_en') or '(empty)'}"
        )
        self.answer_text.delete("1.0", END)
        self.answer_text.insert("1.0", text)

    def get_status(self, question_id: int) -> str | None:
        if not self.conn:
            return None
        cur = self.conn.cursor()
        row = cur.execute(
            "SELECT status FROM user_status WHERE question_id=? ORDER BY rowid DESC LIMIT 1",
            (question_id,),
        ).fetchone()
        return row[0] if row else None

    def mark_status(self, status: str) -> None:
        question = self.get_current()
        if not question or not self.conn:
            return
        cur = self.conn.cursor()
        cur.execute("DELETE FROM user_status WHERE question_id=?", (question["id"],))
        cur.execute(
            "INSERT INTO user_status (question_id, status, updated_at) VALUES (?, ?, datetime('now'))",
            (question["id"], status),
        )
        self.conn.commit()
        self.status_info.set(f"状态：{status}")
        # may change filtered set
        if self.filter_mode != "All":
            self.apply_filter()
        self.save_progress()

    def open_settings(self) -> None:
        win = Toplevel(self.root)
        win.title("DeepSeek 设置")
        win.geometry("520x140")

        ttk.Label(win, text="DeepSeek API Key（可明文修改）").pack(anchor="w", padx=10, pady=(10, 4))
        key_var = StringVar(value=self.api_key)
        entry = ttk.Entry(win, textvariable=key_var)
        entry.pack(fill=X, padx=10, pady=4)

        def save_key() -> None:
            self.api_key = key_var.get().strip()
            self.config["deepseek_api_key"] = self.api_key
            save_config(self.config)
            messagebox.showinfo("成功", "Key 已保存")
            win.destroy()

        ttk.Button(win, text="保存", command=save_key).pack(anchor="e", padx=10, pady=10)

    def ask_ai_custom(self) -> None:
        text = self.custom_entry.get().strip()
        if not text:
            messagebox.showwarning("提示", "请先输入自定义问题")
            return
        self.ask_ai(text)

    def ask_ai(self, instruction: str) -> None:
        if not self.api_key:
            messagebox.showwarning("缺少 Key", "请先在设置中填写 DeepSeek API Key")
            return

        question = self.get_current()
        if not question:
            return

        self._append_ai_block("用户提问", instruction)
        self._append_ai_block("系统", "正在请求 DeepSeek，请稍候...")

        prompt = self._build_prompt(question, instruction)

        def worker() -> None:
            try:
                response = requests.post(
                    "https://api.deepseek.com/chat/completions",
                    headers={
                        "Authorization": f"Bearer {self.api_key}",
                        "Content-Type": "application/json",
                    },
                    json={
                        "model": "deepseek-chat",
                        "messages": [
                            {"role": "system", "content": "你是 AWS-SAA 学习助教，请简洁、准确、中文回答。"},
                            {"role": "user", "content": prompt},
                        ],
                        "temperature": 0.3,
                    },
                    timeout=120,
                )
                response.raise_for_status()
                data = response.json()
                output = data["choices"][0]["message"]["content"]
                self.root.after(0, lambda: self._append_ai_block("AI 回复", output))
            except Exception as exc:
                logging.exception("DeepSeek request failed")
                def handle_error():
                    messagebox.showerror("请求失败", str(exc))
                    self._append_ai_block("系统", f"请求失败：{exc}")
                self.root.after(0, handle_error)

        threading.Thread(target=worker, daemon=True).start()

    def _build_prompt(self, question: dict, instruction: str) -> str:
        options_zh = self._safe_json_list(question.get("options_zh"))
        options_en = self._safe_json_list(question.get("options_en"))
        ai_history = self.ai_text.get("1.0", END).strip()
        return (
            f"用户提问：{instruction}\n\n"
            f"题号：{question.get('q_num')}\n\n"
            f"中文题干：\n{question.get('stem_zh') or ''}\n\n"
            f"中文选项：\n" + "\n".join(options_zh) + "\n\n"
            f"英文题干：\n{question.get('stem_en') or ''}\n\n"
            f"英文选项：\n" + "\n".join(options_en) + "\n\n"
            f"当前答案：{question.get('correct_answer') or ''}\n"
            f"中文解析：{question.get('explanation_zh') or ''}\n"
            f"英文解析：{question.get('explanation_en') or ''}\n"
            f"\n历史对话（AI输出框累计内容）：\n{ai_history}\n"
        )

    def _append_ai_block(self, title: str, text: str) -> None:
        self.ai_text.insert(END, f"\n[{title}]\n{text}\n")
        self.ai_text.see(END)

    def clear_ai_history(self) -> None:
        self.ai_text.delete("1.0", END)

    def _setup_ai_context_menu(self) -> None:
        menu = Menu(self.root, tearoff=0)
        menu.add_command(label="清空历史", command=self.clear_ai_history)

        def show_menu(event) -> None:
            menu.tk_popup(event.x_root, event.y_root)

        self.ai_text.bind("<Button-3>", show_menu)

    # -----------------------------------------------------------
    # auxiliary methods for filtering, progress and navigation
    # -----------------------------------------------------------

    def save_progress(self) -> None:
        """remember current index per database in config."""
        if not self.db_path:
            return
        self.config.setdefault("last_index", {})[self.db_path] = self.current_index
        save_config(self.config)

    def update_progress_info(self) -> None:
        idx = self.current_index + 1
        total = len(self.questions)
        self.progress_var.set(f"进度: {idx}/{total}")

    def apply_filter(self) -> None:
        mode = self.filter_var.get()
        self.filter_mode = mode
        self.config["filter_mode"] = mode
        save_config(self.config)

        if mode == "All":
            self.questions = list(self.all_questions)
        else:
            self.questions = [
                q
                for q in self.all_questions
                if self.get_status(q["id"]) == mode
            ]

        if self.random_var.get():
            random.shuffle(self.questions)

        self.current_index = 0
        self.render_question()

    def clear_filter(self) -> None:
        self.filter_var.set("All")
        self.apply_filter()

    def go_to_question(self) -> None:
        try:
            num = int(self.jump_var.get())
        except ValueError:
            messagebox.showwarning("输入错误", "请输入有效的题号")
            return
        if num < 1 or num > len(self.questions):
            messagebox.showwarning("范围错误", "题号超出范围")
            return
        self.current_index = num - 1
        self.render_question()

    def toggle_random(self) -> None:
        self.random_order = self.random_var.get()
        self.config["random_order"] = self.random_order
        save_config(self.config)

        if self.random_order:
            random.shuffle(self.questions)
        else:
            order = {q["id"]: i for i, q in enumerate(self.all_questions)}
            self.questions.sort(key=lambda q: order.get(q["id"], 0))

        self.current_index = 0
        self.render_question()


def main() -> None:
    root = Tk()
    app = QBankApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
