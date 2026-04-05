#!/usr/bin/env python3
"""Apply high-confidence corrections from DOCX compare results to ISPM bank.

This script focuses on practical quality gains:
- Fill missing answers from DOCX
- Fix mismatched answers when match score is high
- Fill missing/incomplete options from DOCX blocks when parseable
"""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
from dataclasses import dataclass
from pathlib import Path
from zipfile import ZipFile
import xml.etree.ElementTree as ET


NS = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}


@dataclass
class DocxBlock:
    block_id: int
    text: str
    answer: str | None


def read_docx_paragraphs(path: Path) -> list[str]:
    with ZipFile(path) as zf:
        xml = zf.read("word/document.xml")
    root = ET.fromstring(xml)
    lines: list[str] = []
    for p in root.findall(".//w:p", NS):
        ts = [t.text or "" for t in p.findall(".//w:t", NS)]
        line = "".join(ts).strip()
        if line:
            lines.append(line)
    return lines


def split_docx_blocks(lines: list[str]) -> list[DocxBlock]:
    text = "\n".join(lines)
    marks = list(re.finditer(r"试题\s*\d+\s*[-—]", text))
    blocks: list[DocxBlock] = []
    for i, m in enumerate(marks):
        start = m.start()
        end = marks[i + 1].start() if i + 1 < len(marks) else len(text)
        block_text = text[start:end].strip()
        ans_m = re.search(r"(?:答案|参考答案|正确答案)\s*[】\]:：\s\(（]*([A-F])", block_text, re.I)
        ans = ans_m.group(1).upper() if ans_m else None
        blocks.append(DocxBlock(block_id=i + 1, text=block_text, answer=ans))
    return blocks


def parse_docx_options(block_text: str) -> list[str]:
    # Prefer extracting from prompt area before answer/analysis.
    prompt = re.split(r"(?:答案|参考答案|正确答案|解析|要点点评)\s*[】\]:：]", block_text, maxsplit=1)[0]
    matches = list(re.finditer(r"([A-F])[\.、\)]\s*", prompt))
    if len(matches) < 2:
        return []

    options: list[str] = []
    for i, m in enumerate(matches):
        label = m.group(1).upper()
        start = m.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(prompt)
        content = prompt[start:end].strip()
        content = re.split(r"\n\s*[【\[]", content, maxsplit=1)[0].strip()
        content = re.sub(r"\s+", " ", content)
        if content:
            options.append(f"{label}. {content}")
    return options


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def save_json(path: Path, data) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Apply high-confidence DOCX corrections to ISPM bank")
    parser.add_argument("--bank-json", default="assets/banks/ispm/questions.json")
    parser.add_argument("--bank-db", default="assets/banks/ispm/data.db")
    parser.add_argument("--compare-json", default="reports/ispm_docx_compare_full.json")
    parser.add_argument("--docx-1", default="题库/ISPM_ocr_pdfsandwich/ISPM_merged_selected-case-essay_1-200.docx")
    parser.add_argument("--docx-2", default="题库/ISPM_ocr_pdfsandwich/ISPM_merged_selected-case-essay_201-361.docx")
    parser.add_argument("--min-score", type=float, default=0.90)
    args = parser.parse_args()

    bank_json = Path(args.bank_json)
    bank_db = Path(args.bank_db)
    compare_json = Path(args.compare_json)
    docx1 = Path(args.docx_1)
    docx2 = Path(args.docx_2)

    rows = load_json(bank_json)
    compare_rows = load_json(compare_json)
    lines = read_docx_paragraphs(docx1) + read_docx_paragraphs(docx2)
    blocks = split_docx_blocks(lines)
    block_map = {b.block_id: b for b in blocks}

    by_id = {int(r["id"]): r for r in rows}

    answer_filled = 0
    answer_fixed = 0
    options_filled = 0
    options_upgraded = 0

    for cmp_row in compare_rows:
        score = float(cmp_row.get("match_score") or 0.0)
        if score < args.min_score:
            continue

        qid = int(cmp_row["id"])
        row = by_id.get(qid)
        if not row:
            continue

        block_id = cmp_row.get("docx_block_id")
        block = block_map.get(int(block_id)) if block_id else None
        if not block:
            continue

        bank_answer = (row.get("correct_answer") or "").strip().upper()
        docx_answer = (cmp_row.get("docx_answer") or "").strip().upper()

        if docx_answer:
            if not bank_answer:
                row["correct_answer"] = docx_answer
                answer_filled += 1
            elif bank_answer != docx_answer:
                row["correct_answer"] = docx_answer
                answer_fixed += 1

        # Objective-only option corrections.
        source_doc = (row.get("source_doc") or "").lower()
        if ":objective:" not in source_doc:
            continue

        old_options_raw = row.get("options_zh")
        old_options = []
        if old_options_raw:
            try:
                old_options = list(json.loads(old_options_raw))
            except Exception:
                old_options = []

        new_options = parse_docx_options(block.text)
        if len(new_options) >= 4:
            if not old_options:
                row["options_zh"] = json.dumps(new_options, ensure_ascii=False)
                options_filled += 1
            elif len(old_options) < 4:
                row["options_zh"] = json.dumps(new_options, ensure_ascii=False)
                options_upgraded += 1

    # Persist JSON
    ordered_rows = [by_id[int(r["id"])] for r in rows]
    save_json(bank_json, ordered_rows)

    # Persist DB (only update touched columns for all ids)
    conn = sqlite3.connect(str(bank_db))
    cur = conn.cursor()
    for r in ordered_rows:
        cur.execute(
            "UPDATE questions SET options_zh=?, correct_answer=? WHERE id=?",
            (r.get("options_zh"), r.get("correct_answer"), int(r["id"])),
        )
    conn.commit()
    conn.close()

    print(
        json.dumps(
            {
                "rows": len(ordered_rows),
                "answer_filled": answer_filled,
                "answer_fixed": answer_fixed,
                "options_filled": options_filled,
                "options_upgraded": options_upgraded,
                "min_score": args.min_score,
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
