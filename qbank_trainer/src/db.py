import sqlite3
from pathlib import Path


def init_db(db_path: str) -> None:
    path = Path(db_path)
    path.parent.mkdir(parents=True, exist_ok=True)

    with sqlite3.connect(path) as conn:
        cursor = conn.cursor()
        cursor.execute(
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
        cursor.execute(
            """
            CREATE TABLE IF NOT EXISTS user_status (
                question_id INTEGER,
                status TEXT,
                updated_at TEXT,
                FOREIGN KEY(question_id) REFERENCES questions(id)
            )
            """
        )
        cursor.execute(
            """
            CREATE TABLE IF NOT EXISTS import_jobs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source_doc TEXT,
                created_at TEXT,
                notes TEXT
            )
            """
        )
        conn.commit()
