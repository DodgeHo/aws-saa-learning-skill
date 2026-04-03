#!/usr/bin/env python3
"""Generate a human-review report for suspicious ISPM questions."""

from __future__ import annotations

import argparse
import json
import re
from collections import Counter
from pathlib import Path


def load_rows(path: Path) -> list[dict]:
    return json.loads(path.read_text(encoding="utf-8"))


def detect_type(row: dict) -> str:
    source = (row.get("source_doc") or "").lower()
    if ":objective:" in source:
        return "objective"
    if ":case:" in source:
        return "case"
    if ":essay:" in source:
        return "essay"
    return "unknown"


def parse_options(row: dict) -> list[str]:
    raw = row.get("options_zh")
    if not raw:
        return []
    try:
        data = json.loads(raw)
    except Exception:
        return []
    return [str(item) for item in data]


def summarize_text(text: str, limit: int = 140) -> str:
    clean = re.sub(r"\s+", " ", (text or "").strip())
    return clean[:limit] + ("..." if len(clean) > limit else "")


def collect_issues(rows: list[dict]) -> list[dict]:
    issues: list[dict] = []
    for row in rows:
        qtype = detect_type(row)
        if qtype != "objective":
            continue

        stem = row.get("stem_zh") or ""
        explanation = row.get("explanation_zh") or ""
        options = parse_options(row)
        answer = (row.get("correct_answer") or "").strip()

        problem_tags: list[str] = []
        priority = "medium"

        if not options:
            problem_tags.append("missing_options")
            priority = "high"
        if not answer:
            problem_tags.append("missing_answer")
            priority = "high"
        if options and len(options) < 4:
            problem_tags.append("too_few_options")
        if any(("【" in item or "答案" in item or "解析" in item) for item in options):
            problem_tags.append("option_tail_noise")
        if "@" in stem or any("@" in item for item in options):
            problem_tags.append("ocr_marker")
        if not options and re.search(r"(?:^|\s)[A-F][\.、\)]", stem):
            problem_tags.append("options_embedded_in_stem")

        if not problem_tags:
            continue

        issues.append(
            {
                "id": row["id"],
                "q_num": row.get("q_num"),
                "source_doc": row.get("source_doc"),
                "priority": priority,
                "problem_tags": problem_tags,
                "answer": answer or "-",
                "option_count": len(options),
                "stem_preview": summarize_text(stem),
                "explanation_preview": summarize_text(explanation, 100),
            }
        )

    return issues


def render_markdown(issues: list[dict], bank_json: Path) -> str:
    tag_counts = Counter(tag for item in issues for tag in item["problem_tags"])
    high = [item for item in issues if item["priority"] == "high"]
    medium = [item for item in issues if item["priority"] == "medium"]

    lines = [
        "# ISPM 可疑题人工校对清单",
        "",
        f"来源: {bank_json}",
        "",
        "## 说明",
        "",
        "- 这份清单只列出最值得回看原图 PDF 的客观题。",
        "- `id/q_num` 是当前题库内编号；真正回图时请优先看 `source_doc` 和题干预览。",
        "- `missing_answer` 和 `missing_options` 优先级最高，建议先修。",
        "",
        "## 统计",
        "",
        f"- 可疑客观题总数: {len(issues)}",
        f"- 高优先级: {len(high)}",
        f"- 中优先级: {len(medium)}",
    ]

    for tag, count in sorted(tag_counts.items()):
        lines.append(f"- {tag}: {count}")

    def add_section(title: str, items: list[dict]) -> None:
        lines.extend(["", f"## {title}", ""])
        if not items:
            lines.append("- 无")
            return
        for item in items:
            lines.append(
                f"- id={item['id']} q_num={item['q_num']} source={item['source_doc']} "
                f"tags={','.join(item['problem_tags'])} answer={item['answer']} options={item['option_count']}"
            )
            lines.append(f"  stem: {item['stem_preview']}")
            if item["explanation_preview"]:
                lines.append(f"  explanation: {item['explanation_preview']}")

    add_section("高优先级", high)
    add_section("中优先级", medium)
    return "\n".join(lines) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate suspicious ISPM question report")
    parser.add_argument("--questions", default="assets/banks/ispm/questions.json")
    parser.add_argument("--out", default="reports/ispm_suspects_report.md")
    parser.add_argument("--out-json", default="reports/ispm_suspects_report.json")
    args = parser.parse_args()

    questions = Path(args.questions)
    rows = load_rows(questions)
    issues = collect_issues(rows)

    out_md = Path(args.out)
    out_md.parent.mkdir(parents=True, exist_ok=True)
    out_md.write_text(render_markdown(issues, questions), encoding="utf-8")

    out_json = Path(args.out_json)
    out_json.parent.mkdir(parents=True, exist_ok=True)
    out_json.write_text(json.dumps(issues, ensure_ascii=False, indent=2), encoding="utf-8")

    print(json.dumps({"issues": len(issues), "out": str(out_md), "out_json": str(out_json)}, ensure_ascii=False))


if __name__ == "__main__":
    main()