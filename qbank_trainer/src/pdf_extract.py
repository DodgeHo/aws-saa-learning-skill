from __future__ import annotations

from typing import List


def _clean_text(text: str) -> str:
    cleaned = text.replace("\u00a0", " ")
    cleaned = cleaned.replace("\r\n", "\n").replace("\r", "\n")
    cleaned = "\n".join(line.rstrip() for line in cleaned.splitlines())
    return cleaned.strip()


def extract_pages_pypdf(pdf_path: str) -> List[str]:
    from pypdf import PdfReader

    pages: List[str] = []
    reader = PdfReader(pdf_path)
    for page in reader.pages:
        text = page.extract_text() or ""
        pages.append(_clean_text(text))
    return pages


def extract_pages(pdf_path: str) -> List[str]:
    return extract_pages_pypdf(pdf_path)
