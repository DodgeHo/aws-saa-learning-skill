import json
import re
import sqlite3
from pathlib import Path

from pypdf import PdfReader

ROOT = Path(r"C:/Users/asdsa/.copilot/skills/aws-saa-learning")
pdf_zh = ROOT / "题库" / "AWS认证 SAA-C03 中文真题题库.pdf"
pdf_en = ROOT / "题库" / "AWS SAA-C03 英文 1019Q.pdf"
out_db = ROOT / "qbank_trainer" / "data.db"
out_log = ROOT / "qbank_trainer" / "import_once.log"

Q_RE = re.compile(r"(?:^|\n)\s*(\d{1,4})\.")
OPT_RE = re.compile(r"([A-E])[、\.),]")
ANS_RE = re.compile(r"(?:答案|正确答案|Answer|Correct\s*Answer|CorrectAnswer)[:：]?\s*([A-E])", re.I)
EXP_RE = re.compile(r"(?:解析|解释|Explanation|Detailed\s*Explanation|DetailedExplanation)[:：]?\s*(.+)$", re.I | re.S)


def clean(t: str) -> str:
    t = (t or "").replace("\u00a0", " ")
    t = t.replace("\r\n", "\n").replace("\r", "\n")
    lines = [ln.strip() for ln in t.splitlines()]
    return "\n".join([ln for ln in lines if ln])


def read_all_text(pdf_path: Path) -> str:
    reader = PdfReader(str(pdf_path))
    return "\n".join(clean(p.extract_text() or "") for p in reader.pages)


def split_questions(all_text: str):
    matches = list(Q_RE.finditer(all_text))
    result = {}
    for i, match in enumerate(matches):
        q = int(match.group(1))
        if q < 1 or q > 1019:
            continue
        start = match.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(all_text)
        block = all_text[start:end].strip()
        if q not in result or len(block) > len(result[q]):
            result[q] = block
    return result


def trim_tail(text: str) -> str:
    for marker in [
        "答案", "正确答案", "Answer", "Correct Answer", "CorrectAnswer",
        "解析", "解释", "Explanation", "Detailed Explanation", "DetailedExplanation",
    ]:
        idx = text.find(marker)
        if idx != -1:
            text = text[:idx]
    return text.strip()


def parse_block(block: str):
    header = re.match(r"\s*\d{1,4}\.\s*", block)
    body = block[header.end():] if header else block

    option_marks = list(OPT_RE.finditer(body))
    options = []
    stem = body

    if option_marks:
        stem = body[:option_marks[0].start()].strip()
        for i, mark in enumerate(option_marks):
            label = mark.group(1)
            start = mark.end()
            end = option_marks[i + 1].start() if i + 1 < len(option_marks) else len(body)
            opt_text = trim_tail(body[start:end])
            if opt_text:
                options.append(f"{label}. {opt_text}")

    stem = trim_tail(stem)
    ans_match = ANS_RE.search(body)
    exp_match = EXP_RE.search(body)
    answer = ans_match.group(1).upper() if ans_match else None
    explanation = exp_match.group(1).strip() if exp_match else None
    return stem, options, answer, explanation


zh_text = read_all_text(pdf_zh)
en_text = read_all_text(pdf_en)

zh_blocks = split_questions(zh_text)
en_blocks = split_questions(en_text)

rows = []
log = {
    "zh_count": len(zh_blocks),
    "en_count": len(en_blocks),
    "missing_zh": [],
    "missing_en": [],
    "missing_answer": [],
}

for q in range(1, 1020):
    zh_block = zh_blocks.get(q)
    en_block = en_blocks.get(q)

    if not zh_block:
        log["missing_zh"].append(q)
    if not en_block:
        log["missing_en"].append(q)

    stem_zh = options_zh = answer_zh = explanation_zh = None
    stem_en = options_en = answer_en = explanation_en = None

    if zh_block:
        stem_zh, options_zh, answer_zh, explanation_zh = parse_block(zh_block)
    if en_block:
        stem_en, options_en, answer_en, explanation_en = parse_block(en_block)

    answer = answer_en or answer_zh
    if not answer:
        log["missing_answer"].append(q)

    if not any([stem_zh, stem_en, options_zh, options_en]):
        continue

    rows.append((
        str(q),
        stem_en,
        stem_zh,
        json.dumps(options_en or [], ensure_ascii=False),
        json.dumps(options_zh or [], ensure_ascii=False),
        answer,
        explanation_en,
        explanation_zh,
        "one-off-pdf",
        None,
    ))

out_db.parent.mkdir(parents=True, exist_ok=True)
if out_db.exists():
    out_db.unlink()

conn = sqlite3.connect(out_db)
cur = conn.cursor()
cur.execute(
    """
    CREATE TABLE IF NOT EXISTS questions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      q_num TEXT,
      stem_en TEXT,
      stem_zh TEXT,
      options_en TEXT,
      options_zh TEXT,
      correct_answer TEXT,
      explanation_en TEXT,
      explanation_zh TEXT,
      source_doc TEXT,
      source_page INTEGER
    )
    """
)
cur.executemany(
    """
    INSERT INTO questions (
      q_num, stem_en, stem_zh, options_en, options_zh, correct_answer,
      explanation_en, explanation_zh, source_doc, source_page
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """,
    rows,
)
conn.commit()

count = cur.execute("select count(*) from questions").fetchone()[0]
en_miss = cur.execute("select count(*) from questions where stem_en is null or trim(stem_en) = ''").fetchone()[0]
zh_miss = cur.execute("select count(*) from questions where stem_zh is null or trim(stem_zh) = ''").fetchone()[0]
ans_miss = cur.execute("select count(*) from questions where correct_answer is null or trim(correct_answer) = ''").fetchone()[0]
conn.close()

log["inserted"] = count
log["en_stem_missing"] = en_miss
log["zh_stem_missing"] = zh_miss
log["answer_missing_in_db"] = ans_miss

out_log.write_text(json.dumps(log, ensure_ascii=False, indent=2), encoding="utf-8")
print(
    json.dumps(
        {
            "inserted": count,
            "zh_detected": len(zh_blocks),
            "en_detected": len(en_blocks),
            "en_stem_missing": en_miss,
            "zh_stem_missing": zh_miss,
            "answer_missing": ans_miss,
            "log": str(out_log),
        },
        ensure_ascii=False,
    )
)
