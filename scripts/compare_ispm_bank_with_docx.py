#!/usr/bin/env python3
"""Compare every ISPM question row against merged OCR DOCX content.

Outputs:
  reports/ispm_docx_compare_full.json
  reports/ispm_docx_compare_summary.md
"""

from __future__ import annotations

import json
import csv
import re
from dataclasses import dataclass
from difflib import SequenceMatcher
from pathlib import Path
from zipfile import ZipFile
import xml.etree.ElementTree as ET
from collections import defaultdict


NS = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}


@dataclass
class DocxBlock:
    block_id: int
    text: str
    q_num_embedded: int | None
    year_half: str | None
    answer: str | None
    option_count: int


def norm_text(text: str) -> str:
    s = text or ""
    s = s.replace("\u3000", " ")
    s = re.sub(r"\s+", "", s)
    return s


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
    if not marks:
        return []

    blocks: list[DocxBlock] = []
    for i, m in enumerate(marks):
        start = m.start()
        end = marks[i + 1].start() if i + 1 < len(marks) else len(text)
        block = text[start:end].strip()

        q_num_m = re.search(r"第\s*(\d{1,3})\s*题", block)
        q_num = int(q_num_m.group(1)) if q_num_m else None

        yh_m = re.search(r"(20\d{2}年[上下]半年)", block)
        year_half = yh_m.group(1) if yh_m else None

        ans_m = re.search(r"(?:答案|参考答案|正确答案)\s*[】\]:：\s\(（]*([A-F])", block, re.I)
        answer = ans_m.group(1).upper() if ans_m else None

        option_count = len(re.findall(r"(?:^|\n)\s*[A-F][\.、\)]", block))
        if option_count == 0:
            option_count = len(re.findall(r"\b[A-F][\.、\)]", block))

        blocks.append(
            DocxBlock(
                block_id=i + 1,
                text=block,
                q_num_embedded=q_num,
                year_half=year_half,
                answer=answer,
                option_count=option_count,
            )
        )
    return blocks


def extract_year_half_from_source(source_doc: str | None) -> str | None:
    if not source_doc:
        return None
    m = re.search(r"(20\d{2}年[上下]半年)", source_doc)
    return m.group(1) if m else None


def extract_qnum_from_stem(stem: str | None) -> int | None:
    if not stem:
        return None
    m = re.search(r"第\s*(\d{1,3})\s*题", stem)
    return int(m.group(1)) if m else None


def parse_options(raw: str | None) -> list[str]:
    if not raw:
        return []
    try:
        return list(json.loads(raw))
    except Exception:
        return []


def best_match_for_row(
    row: dict,
    blocks: list[DocxBlock],
    key_index: dict[tuple[str, int], list[DocxBlock]],
) -> tuple[DocxBlock | None, float]:
    stem = row.get("stem_zh") or ""
    n_stem = norm_text(stem)
    if not n_stem:
        return None, 0.0

    year_half = extract_year_half_from_source(row.get("source_doc"))
    q_num = extract_qnum_from_stem(stem)

    # Strong-key matching for objective style: year-half + question number.
    if year_half and q_num is not None:
        kb = key_index.get((year_half, q_num), [])
        if kb:
            return kb[0], 0.99

    cands = blocks
    if year_half:
        yh = [b for b in blocks if b.year_half == year_half]
        if yh:
            cands = yh

    if q_num is not None:
        qf = [b for b in cands if b.q_num_embedded == q_num]
        if qf:
            cands = qf

    best = None
    best_score = -1.0
    head = n_stem[:260]
    for b in cands:
        nb = norm_text(b.text)
        bhead = nb[:420]
        score = SequenceMatcher(None, head, bhead).ratio()
        if score > best_score:
            best_score = score
            best = b
    return best, max(best_score, 0.0)


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    bank_json = root / "assets" / "banks" / "ispm" / "questions.json"
    docx1 = root / "题库" / "ISPM_ocr_pdfsandwich" / "ISPM_merged_selected-case-essay_1-200.docx"
    docx2 = root / "题库" / "ISPM_ocr_pdfsandwich" / "ISPM_merged_selected-case-essay_201-361.docx"

    rows = json.loads(bank_json.read_text(encoding="utf-8"))
    lines = read_docx_paragraphs(docx1) + read_docx_paragraphs(docx2)
    blocks = split_docx_blocks(lines)
    key_index: dict[tuple[str, int], list[DocxBlock]] = defaultdict(list)
    for b in blocks:
        if b.year_half and b.q_num_embedded is not None:
            key_index[(b.year_half, b.q_num_embedded)].append(b)

    results = []
    answer_mismatch = 0
    weak_match = 0
    strong_match = 0

    for row in rows:
        best, score = best_match_for_row(row, blocks, key_index)
        opts = parse_options(row.get("options_zh"))
        bank_answer = (row.get("correct_answer") or "").strip().upper()

        docx_answer = best.answer if best else None
        answer_status = "na"
        if bank_answer and docx_answer:
            answer_status = "same" if bank_answer == docx_answer else "mismatch"
            if answer_status == "mismatch":
                answer_mismatch += 1

        if score >= 0.90:
            strong_match += 1
        if score < 0.72:
            weak_match += 1

        results.append(
            {
                "id": row.get("id"),
                "q_num": row.get("q_num"),
                "source_doc": row.get("source_doc"),
                "bank_answer": bank_answer or None,
                "bank_option_count": len(opts),
                "docx_block_id": best.block_id if best else None,
                "docx_year_half": best.year_half if best else None,
                "docx_q_num": best.q_num_embedded if best else None,
                "docx_answer": docx_answer,
                "docx_option_count": best.option_count if best else None,
                "match_score": round(score, 4),
                "answer_status": answer_status,
                "needs_review": bool(score < 0.72 or answer_status == "mismatch"),
            }
        )

    out_full = root / "reports" / "ispm_docx_compare_full.json"
    out_csv = root / "reports" / "ispm_docx_compare_full.csv"
    out_summary = root / "reports" / "ispm_docx_compare_summary.md"
    out_full.write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding="utf-8")

    fieldnames = [
        "id",
        "q_num",
        "source_doc",
        "bank_answer",
        "bank_option_count",
        "docx_block_id",
        "docx_year_half",
        "docx_q_num",
        "docx_answer",
        "docx_option_count",
        "match_score",
        "answer_status",
        "needs_review",
    ]
    with out_csv.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(results)

    needs_review = sum(1 for r in results if r["needs_review"])
    summary_lines = [
        "# ISPM Per-Question DOCX Compare",
        "",
        f"- bank_rows: {len(rows)}",
        f"- docx_blocks: {len(blocks)}",
        f"- strong_match(score>=0.90): {strong_match}",
        f"- weak_match(score<0.72): {weak_match}",
        f"- answer_mismatch(both have answer): {answer_mismatch}",
        f"- needs_manual_review: {needs_review}",
        "",
        "## Review Priority",
        "",
        "- Priority 1: `answer_status=mismatch`",
        "- Priority 2: `match_score<0.72`",
        "",
        "Details: `reports/ispm_docx_compare_full.json`",
        "Spreadsheet: `reports/ispm_docx_compare_full.csv`",
    ]
    out_summary.write_text("\n".join(summary_lines) + "\n", encoding="utf-8")

    print(
        json.dumps(
            {
                "rows": len(rows),
                "docx_blocks": len(blocks),
                "strong_match": strong_match,
                "weak_match": weak_match,
                "answer_mismatch": answer_mismatch,
                "needs_review": needs_review,
                "out_full": str(out_full),
                "out_csv": str(out_csv),
                "out_summary": str(out_summary),
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
