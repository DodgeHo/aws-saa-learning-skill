#!/usr/bin/env python3
import argparse
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any


DEFAULT_API_URL = "https://api.deepseek.com"
DEFAULT_MODEL = "deepseek-chat"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Batch-proofread ISPM questions with DeepSeek and optionally apply fixes."
    )
    parser.add_argument(
        "--input",
        default="assets/banks/ispm/questions.json",
        help="Path to source questions.json",
    )
    parser.add_argument(
        "--output",
        default="reports/ispm_deepseek_suggestions.json",
        help="Path to save suggestions JSON",
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Apply suggested fixes back to --input file",
    )
    parser.add_argument(
        "--batch-size",
        type=int,
        default=15,
        help="Questions per API call",
    )
    parser.add_argument(
        "--type",
        default="objective",
        choices=["objective", "case", "essay", "all"],
        help="Question type filter",
    )
    parser.add_argument(
        "--start-id",
        type=int,
        default=1,
        help="Start question id (inclusive)",
    )
    parser.add_argument(
        "--end-id",
        type=int,
        default=999999,
        help="End question id (inclusive)",
    )
    parser.add_argument(
        "--max-items",
        type=int,
        default=0,
        help="Max question count to process (0 means no limit)",
    )
    parser.add_argument(
        "--sleep-seconds",
        type=float,
        default=1.2,
        help="Delay between API calls",
    )
    parser.add_argument(
        "--api-key",
        default=DEFAULT_API_KEY,
        help="DeepSeek API key (prefer env DEEPSEEK_API_KEY)",
    )
    parser.add_argument(
        "--resume-file",
        default="",
        help="Resume file path (default: <output>.resume.json)",
    )
    parser.add_argument(
        "--restart",
        action="store_true",
        help="Ignore existing resume file and start from scratch",
    )
    parser.add_argument(
        "--api-url",
        default=DEFAULT_API_URL,
        help="Base API URL, e.g. https://api.deepseek.com",
    )
    parser.add_argument(
        "--model",
        default=DEFAULT_MODEL,
        help="Model name, e.g. deepseek-chat",
    )
    return parser.parse_args()


def load_questions(path: Path) -> list[dict[str, Any]]:
    return json.loads(path.read_text(encoding="utf-8"))


def filter_questions(
    rows: list[dict[str, Any]],
    q_type: str,
    start_id: int,
    end_id: int,
    max_items: int,
) -> list[dict[str, Any]]:
    out: list[dict[str, Any]] = []
    for q in rows:
        qid = int(q.get("id", 0))
        if qid < start_id or qid > end_id:
            continue
        actual_type = _normalize_question_type(q)
        if q_type != "all" and actual_type != q_type:
            continue
        out.append(q)
        if max_items > 0 and len(out) >= max_items:
            break
    return out


def _normalize_question_type(q: dict[str, Any]) -> str:
    t = str(q.get("type") or "").strip().lower()
    if t in {"objective", "case", "essay"}:
        return t

    src = str(q.get("source_doc") or "").lower()
    if ":objective:" in src or "选择题" in src:
        return "objective"
    if ":case:" in src or "案例" in src:
        return "case"
    if ":essay:" in src or "论文" in src:
        return "essay"
    return ""


def chunked(items: list[dict[str, Any]], n: int) -> list[list[dict[str, Any]]]:
    return [items[i : i + n] for i in range(0, len(items), n)]


def _json_dumps(obj: Any) -> str:
    return json.dumps(obj, ensure_ascii=False, separators=(",", ":"))


def build_prompt(batch: list[dict[str, Any]]) -> str:
    payload: list[dict[str, Any]] = []
    for q in batch:
        payload.append(
            {
                "id": q.get("id"),
                "type": _normalize_question_type(q),
                "stem_zh": q.get("stem_zh", ""),
                "options_zh": _safe_options(q.get("options_zh", "[]")),
                "analysis_zh": q.get("analysis_zh", ""),
                "correct_answer": q.get("correct_answer", ""),
            }
        )

    instruction = {
        "role": "system",
        "content": (
            "你是中文考试题库清洗助手。只修复中文格式、错别字、空格断裂、语句不通顺。"
            "严禁改动题意、知识点、题号、正确答案字母、选项顺序。"
            "如果无法确定就保持原文。"
        ),
    }
    user = {
        "role": "user",
        "content": (
            "请返回严格 JSON 数组，不要 Markdown。每项格式:\n"
            "{id:int, stem_zh:string, options_zh:[string], analysis_zh:string, changed:boolean, note:string}\n"
            "要求:\n"
            "1) changed=true 仅在你实际修改了文本时\n"
            "2) 不要新增字段\n"
            "3) id 必须与输入一致\n"
            "输入:\n"
            f"{_json_dumps(payload)}"
        ),
    }
    return _json_dumps([instruction, user])


def _safe_options(raw: Any) -> list[str]:
    if isinstance(raw, list):
        return [str(x) for x in raw]
    if isinstance(raw, str):
        try:
            data = json.loads(raw)
            if isinstance(data, list):
                return [str(x) for x in data]
        except Exception:
            return []
    return []


def call_deepseek(api_key: str, api_url: str, model: str, messages_json: str) -> str:
    base = api_url.rstrip("/")
    endpoint = base if base.endswith("/chat/completions") else f"{base}/chat/completions"
    body = {
        "model": model,
        "messages": json.loads(messages_json),
        "temperature": 0.1,
    }
    req = urllib.request.Request(
        endpoint,
        data=json.dumps(body, ensure_ascii=False).encode("utf-8"),
        headers={
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            return resp.read().decode("utf-8")
    except urllib.error.HTTPError as e:
        detail = e.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"DeepSeek HTTP {e.code}: {detail}") from e


def extract_content(raw_response: str) -> str:
    data = json.loads(raw_response)
    choices = data.get("choices") or []
    if not choices:
        raise RuntimeError("DeepSeek response missing choices")
    msg = choices[0].get("message", {})
    content = msg.get("content", "")
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts: list[str] = []
        for part in content:
            if isinstance(part, dict):
                t = part.get("text")
                if isinstance(t, str):
                    parts.append(t)
        return "\n".join(parts)
    return str(content)


def parse_model_json(text: str) -> list[dict[str, Any]]:
    s = text.strip()
    if s.startswith("```"):
        s = re.sub(r"^```(?:json)?\s*", "", s)
        s = re.sub(r"\s*```$", "", s)
    try:
        obj = json.loads(s)
    except json.JSONDecodeError:
        start = s.find("[")
        end = s.rfind("]")
        if start >= 0 and end > start:
            obj = json.loads(s[start : end + 1])
        else:
            raise
    if not isinstance(obj, list):
        raise RuntimeError("Model output is not JSON array")
    return [x for x in obj if isinstance(x, dict)]


def apply_suggestions(
    original_rows: list[dict[str, Any]],
    suggestions: list[dict[str, Any]],
) -> tuple[list[dict[str, Any]], int]:
    by_id = {int(q.get("id")): q for q in original_rows}
    changed = 0
    for s in suggestions:
        try:
            qid = int(s.get("id"))
        except Exception:
            continue
        q = by_id.get(qid)
        if not q:
            continue
        if not bool(s.get("changed", False)):
            continue

        new_stem = str(s.get("stem_zh", q.get("stem_zh", ""))).strip()
        new_analysis = str(s.get("analysis_zh", q.get("analysis_zh", ""))).strip()
        raw_options = s.get("options_zh", [])
        new_opts = [str(x).strip() for x in raw_options] if isinstance(raw_options, list) else None

        touched = False
        if new_stem and new_stem != (q.get("stem_zh") or ""):
            q["stem_zh"] = new_stem
            touched = True
        if new_analysis != (q.get("analysis_zh") or ""):
            q["analysis_zh"] = new_analysis
            touched = True
        if new_opts is not None and new_opts:
            old_opts = _safe_options(q.get("options_zh", "[]"))
            if old_opts != new_opts:
                q["options_zh"] = _json_dumps(new_opts)
                touched = True

        if touched:
            changed += 1
    return original_rows, changed


def _get_resume_path(output_path: Path, resume_arg: str) -> Path:
    if resume_arg.strip():
        return Path(resume_arg.strip())
    return output_path.with_suffix(output_path.suffix + ".resume.json")


def _load_resume(path: Path) -> dict[str, Any]:
    if not path.exists():
        return {"processed_ids": [], "suggestions": []}
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return {"processed_ids": [], "suggestions": []}
    if not isinstance(data, dict):
        return {"processed_ids": [], "suggestions": []}
    processed = data.get("processed_ids")
    suggestions = data.get("suggestions")
    if not isinstance(processed, list):
        processed = []
    if not isinstance(suggestions, list):
        suggestions = []
    return {"processed_ids": processed, "suggestions": suggestions}


def _save_resume(path: Path, processed_ids: set[int], suggestions_by_id: dict[int, dict[str, Any]]) -> None:
    payload = {
        "processed_ids": sorted(processed_ids),
        "suggestions": [suggestions_by_id[k] for k in sorted(suggestions_by_id.keys())],
    }
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


def _to_suggestion_map(items: list[dict[str, Any]]) -> dict[int, dict[str, Any]]:
    out: dict[int, dict[str, Any]] = {}
    for item in items:
        if not isinstance(item, dict):
            continue
        try:
            sid = int(item.get("id"))
        except Exception:
            continue
        out[sid] = item
    return out


def main() -> int:
    args = parse_args()
    in_path = Path(args.input)
    out_path = Path(args.output)

    if not in_path.exists():
        print(f"[ERROR] input file not found: {in_path}")
        return 2

    api_key = (args.api_key or os.getenv("DEEPSEEK_API_KEY", "")).strip()
    if not api_key:
        print("[ERROR] missing API key. Use --api-key or set DEEPSEEK_API_KEY.")
        return 2

    rows = load_questions(in_path)
    target_rows = filter_questions(rows, args.type, args.start_id, args.end_id, args.max_items)
    if not target_rows:
        print("[INFO] no questions selected by filter.")
        return 0

    batches = chunked(target_rows, max(1, args.batch_size))
    resume_path = _get_resume_path(out_path, args.resume_file)

    if args.restart and resume_path.exists():
        resume_path.unlink()

    resume = _load_resume(resume_path)
    processed_ids: set[int] = set()
    for x in resume.get("processed_ids", []):
        try:
            processed_ids.add(int(x))
        except Exception:
            continue

    suggestions_by_id = _to_suggestion_map(resume.get("suggestions", []))

    target_ids = {int(q.get("id", 0)) for q in target_rows}
    processed_ids = {x for x in processed_ids if x in target_ids}
    suggestions_by_id = {k: v for k, v in suggestions_by_id.items() if k in target_ids}

    print(
        f"[INFO] selected={len(target_rows)}, batches={len(batches)}, "
        f"resumed_done={len(processed_ids)}"
    )
    for idx, batch in enumerate(batches, start=1):
        batch_ids = []
        for q in batch:
            try:
                batch_ids.append(int(q.get("id")))
            except Exception:
                continue

        if batch_ids and all(bid in processed_ids for bid in batch_ids):
            print(f"[INFO] batch {idx}/{len(batches)} skipped (already processed)")
            continue

        prompt = build_prompt(batch)
        print(f"[INFO] batch {idx}/{len(batches)} size={len(batch)}")
        raw = call_deepseek(api_key, args.api_url, args.model, prompt)
        content = extract_content(raw)
        parsed = parse_model_json(content)

        parsed_map = _to_suggestion_map(parsed)
        expected = set(batch_ids)
        got = {x for x in parsed_map.keys() if x in expected}
        missing = expected - got
        if missing:
            _save_resume(resume_path, processed_ids, suggestions_by_id)
            raise RuntimeError(
                f"DeepSeek output missing ids in batch {idx}: {sorted(missing)}"
            )

        for sid, item in parsed_map.items():
            if sid in expected:
                suggestions_by_id[sid] = item
        processed_ids.update(expected)
        _save_resume(resume_path, processed_ids, suggestions_by_id)

        if idx < len(batches) and args.sleep_seconds > 0:
            time.sleep(args.sleep_seconds)

    all_suggestions = [
        suggestions_by_id[int(q.get("id"))]
        for q in target_rows
        if int(q.get("id", 0)) in suggestions_by_id
    ]

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(all_suggestions, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"[OK] suggestions saved: {out_path}")
    print(f"[OK] resume saved: {resume_path}")

    if args.apply:
        updated_rows, changed_count = apply_suggestions(rows, all_suggestions)
        in_path.write_text(json.dumps(updated_rows, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"[OK] applied changes to {in_path}, changed_questions={changed_count}")
    else:
        print("[INFO] apply disabled. Review suggestion file first.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
