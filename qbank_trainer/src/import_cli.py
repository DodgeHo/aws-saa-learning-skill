from __future__ import annotations

import argparse
import json
import logging
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

from .db import init_db
from .parse_questions import QuestionBlock, parse_questions
from .pdf_extract import extract_pages


def _setup_logger(log_path: str) -> logging.Logger:
    logger = logging.getLogger("importer")
    logger.setLevel(logging.INFO)
    handler = logging.FileHandler(log_path, encoding="utf-8")
    handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)s %(message)s"))
    logger.addHandler(handler)
    return logger


def _serialize_options(options: List[str]) -> str:
    return json.dumps(options, ensure_ascii=False)


def _pair_questions(
    zh: List[QuestionBlock], en: List[QuestionBlock], logger: logging.Logger
) -> List[Dict[str, Optional[QuestionBlock]]]:
    pairs: List[Dict[str, Optional[QuestionBlock]]] = []
    zh_map = {q.q_num: q for q in zh}
    en_map = {q.q_num: q for q in en}

    q_nums = sorted({*zh_map.keys(), *en_map.keys()}, key=lambda value: int(value))
    for q_num in q_nums:
        zh_q = zh_map.get(q_num)
        en_q = en_map.get(q_num)
        if not zh_q:
            logger.info("Missing ZH question q_num=%s", q_num)
        if not en_q:
            logger.info("Missing EN question q_num=%s", q_num)
        pairs.append({"zh": zh_q, "en": en_q})
    return pairs


def _insert_questions(db_path: str, source_doc: str, pairs: List[Dict[str, Optional[QuestionBlock]]]) -> None:
    import sqlite3

    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        for pair in pairs:
            zh_q = pair["zh"]
            en_q = pair["en"]
            q_num = zh_q.q_num if zh_q else (en_q.q_num if en_q else None)
            cursor.execute(
                """
                INSERT INTO questions (
                    q_num,
                    stem_en,
                    stem_zh,
                    options_en,
                    options_zh,
                    correct_answer,
                    explanation_en,
                    explanation_zh,
                    source_doc,
                    source_page
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    q_num,
                    en_q.stem if en_q else None,
                    zh_q.stem if zh_q else None,
                    _serialize_options(en_q.options) if en_q else None,
                    _serialize_options(zh_q.options) if zh_q else None,
                    en_q.answer if en_q and en_q.answer else (zh_q.answer if zh_q else None),
                    en_q.explanation if en_q else None,
                    zh_q.explanation if zh_q else None,
                    source_doc,
                    en_q.source_page if en_q else (zh_q.source_page if zh_q else None),
                ),
            )
        conn.commit()


def main() -> None:
    parser = argparse.ArgumentParser(description="Import bilingual AWS SAA PDFs into SQLite.")
    parser.add_argument("--pdf-zh", required=True, help="Path to the Chinese PDF")
    parser.add_argument("--pdf-en", required=True, help="Path to the English PDF")
    parser.add_argument("--db", required=True, help="Output SQLite database path")
    parser.add_argument("--log", required=True, help="Log file path")
    args = parser.parse_args()

    log_path = Path(args.log)
    log_path.parent.mkdir(parents=True, exist_ok=True)
    logger = _setup_logger(str(log_path))

    logger.info("Starting import")
    db_path = Path(args.db)
    if db_path.exists():
        db_path.unlink()
    init_db(args.db)

    logger.info("Extracting ZH PDF: %s", args.pdf_zh)
    zh_pages = extract_pages(args.pdf_zh)
    logger.info("Extracting EN PDF: %s", args.pdf_en)
    en_pages = extract_pages(args.pdf_en)

    logger.info("Parsing ZH questions")
    zh_questions = parse_questions(zh_pages, "zh")
    logger.info("Parsing EN questions")
    en_questions = parse_questions(en_pages, "en")

    logger.info("Parsed ZH: %s, EN: %s", len(zh_questions), len(en_questions))
    pairs = _pair_questions(zh_questions, en_questions, logger)

    logger.info("Writing to SQLite: %s", args.db)
    _insert_questions(args.db, "bilingual-pdf", pairs)

    logger.info("Import completed at %s", datetime.utcnow().isoformat())


if __name__ == "__main__":
    main()
