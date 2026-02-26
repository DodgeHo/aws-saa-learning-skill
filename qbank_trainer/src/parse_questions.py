from __future__ import annotations

import re
from dataclasses import dataclass
from typing import List, Optional, Tuple


@dataclass
class QuestionBlock:
    q_num: str
    stem: str
    options: List[str]
    answer: Optional[str]
    explanation: Optional[str]
    source_page: int


_Q_SPLIT_RE = re.compile(r"(?:^|\n)\s*(\d{1,4})\.")
_OPT_MARK_RE = re.compile(r"([A-E])[\).、,]")
_ANS_RE = re.compile(r"(?:答案|正确答案|Answer|Correct\s*Answer|CorrectAnswer)[:：]?\s*([A-E])\b", re.I)
_EXP_RE = re.compile(r"(?:解析|解释|Explanation|Detailed\s*Explanation|DetailedExplanation)[:：]?\s*(.+)$", re.I | re.S)


def _split_by_questions(text: str, lang: str) -> List[Tuple[str, str]]:
    del lang
    matches = list(_Q_SPLIT_RE.finditer(text))
    if not matches:
        return []

    blocks: List[Tuple[str, str]] = []
    for idx, match in enumerate(matches):
        start = match.start()
        end = matches[idx + 1].start() if idx + 1 < len(matches) else len(text)
        q_num = match.group(1)
        blocks.append((q_num, text[start:end].strip()))
    return blocks


def _extract_options(block_text: str, lang: str) -> List[str]:
    del lang
    options: List[str] = []
    markers = list(_OPT_MARK_RE.finditer(block_text))
    for idx, marker in enumerate(markers):
        label = marker.group(1).strip()
        start = marker.end()
        end = markers[idx + 1].start() if idx + 1 < len(markers) else len(block_text)
        body = block_text[start:end].strip()
        body = _trim_tail_sections(body)
        if body:
            options.append(f"{label}. {body}")
    return options


def _extract_answer(block_text: str, lang: str) -> Optional[str]:
    del lang
    match = _ANS_RE.search(block_text)
    return match.group(1) if match else None


def _extract_explanation(block_text: str, lang: str) -> Optional[str]:
    del lang
    match = _EXP_RE.search(block_text)
    return match.group(1).strip() if match else None


def _trim_tail_sections(text: str) -> str:
    for marker in ["答案", "正确答案", "Answer", "CorrectAnswer", "Correct Answer", "解析", "解释", "Explanation", "DetailedExplanation", "Detailed Explanation"]:
        idx = text.find(marker)
        if idx != -1:
            return text[:idx].strip()
    return text.strip()


def _extract_stem(block_text: str, options: List[str], answer: Optional[str], explanation: Optional[str]) -> str:
    text = block_text
    if options:
        first_opt = options[0].split(". ", 1)[0]
        opt_idx = -1
        for token in [f"{first_opt}.", f"{first_opt})", f"{first_opt}、", f"{first_opt},"]:
            idx = text.find(token)
            if idx != -1:
                opt_idx = idx
                break
        if opt_idx != -1:
            text = text[:opt_idx].strip()
    if answer:
        text = _trim_tail_sections(text)
    if explanation:
        text = _trim_tail_sections(text)
    lines = text.splitlines()
    if lines and re.match(r"^\s*\d{1,4}\.", lines[0]):
        lines = lines[1:]
    return "\n".join(line.strip() for line in lines).strip()


def parse_questions(pages: List[str], lang: str) -> List[QuestionBlock]:
    questions: List[QuestionBlock] = []
    for page_idx, page_text in enumerate(pages, start=1):
        blocks = _split_by_questions(page_text, lang)
        for q_num, block_text in blocks:
            options = _extract_options(block_text, lang)
            if len(options) < 3:
                continue
            answer = _extract_answer(block_text, lang)
            explanation = _extract_explanation(block_text, lang)
            stem = _extract_stem(block_text, options, answer, explanation)
            if not stem:
                continue
            questions.append(
                QuestionBlock(
                    q_num=q_num,
                    stem=stem,
                    options=options,
                    answer=answer,
                    explanation=explanation,
                    source_page=page_idx,
                )
            )
    return questions
