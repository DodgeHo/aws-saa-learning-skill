#!/usr/bin/env python3
"""Export remaining ISPM manual review tasks from compare result."""

from __future__ import annotations

import csv
import json
from pathlib import Path


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    compare_path = root / "reports" / "ispm_docx_compare_full.json"
    rows = json.loads(compare_path.read_text(encoding="utf-8"))

    def is_objective(row: dict) -> bool:
        src = (row.get("source_doc") or "").lower()
        return ":objective:" in src

    objective_rows = [r for r in rows if is_objective(r)]

    mismatches = [r for r in objective_rows if r.get("answer_status") == "mismatch"]
    weak = [r for r in objective_rows if float(r.get("match_score") or 0.0) < 0.72]

    # Remove duplicates from weak list if already in mismatch
    mismatch_ids = {int(r["id"]) for r in mismatches}
    weak = [r for r in weak if int(r["id"]) not in mismatch_ids]

    mismatch_out_json = root / "reports" / "ispm_manual_review_answer_mismatch.json"
    weak_out_json = root / "reports" / "ispm_manual_review_weak_match.json"
    mismatch_out_json.write_text(json.dumps(mismatches, ensure_ascii=False, indent=2), encoding="utf-8")
    weak_out_json.write_text(json.dumps(weak, ensure_ascii=False, indent=2), encoding="utf-8")

    csv_path = root / "reports" / "ispm_manual_review_tasks.csv"
    fieldnames = [
        "group",
        "id",
        "q_num",
        "source_doc",
        "bank_answer",
        "docx_answer",
        "match_score",
        "answer_status",
        "needs_review",
    ]
    with csv_path.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for r in mismatches:
            writer.writerow(
                {
                    "group": "answer_mismatch",
                    "id": r.get("id"),
                    "q_num": r.get("q_num"),
                    "source_doc": r.get("source_doc"),
                    "bank_answer": r.get("bank_answer"),
                    "docx_answer": r.get("docx_answer"),
                    "match_score": r.get("match_score"),
                    "answer_status": r.get("answer_status"),
                    "needs_review": r.get("needs_review"),
                }
            )
        for r in weak:
            writer.writerow(
                {
                    "group": "weak_match",
                    "id": r.get("id"),
                    "q_num": r.get("q_num"),
                    "source_doc": r.get("source_doc"),
                    "bank_answer": r.get("bank_answer"),
                    "docx_answer": r.get("docx_answer"),
                    "match_score": r.get("match_score"),
                    "answer_status": r.get("answer_status"),
                    "needs_review": r.get("needs_review"),
                }
            )

    md_path = root / "reports" / "ispm_manual_review_tasks.md"
    lines = [
        "# ISPM Remaining Manual Review Tasks",
        "",
        f"- answer_mismatch: {len(mismatches)}",
        f"- weak_match: {len(weak)}",
        f"- total: {len(mismatches) + len(weak)}",
        "",
        "## Priority 1: Answer Mismatch",
        "",
    ]
    if not mismatches:
        lines.append("- none")
    else:
        for r in mismatches:
            lines.append(
                f"- id={r.get('id')} q_num={r.get('q_num')} source={r.get('source_doc')} "
                f"bank={r.get('bank_answer')} docx={r.get('docx_answer')} score={r.get('match_score')}"
            )

    lines.extend(["", "## Priority 2: Weak Match", ""])
    if not weak:
        lines.append("- none")
    else:
        for r in weak:
            lines.append(
                f"- id={r.get('id')} q_num={r.get('q_num')} source={r.get('source_doc')} "
                f"bank={r.get('bank_answer')} docx={r.get('docx_answer')} score={r.get('match_score')}"
            )

    md_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(
        json.dumps(
            {
                "answer_mismatch": len(mismatches),
                "weak_match": len(weak),
                "total": len(mismatches) + len(weak),
                "md": str(md_path),
                "csv": str(csv_path),
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
