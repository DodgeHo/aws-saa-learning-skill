# Windows AWS-SAA Bilingual QBank Trainer - Project Plan

## Goals
- Provide a Windows desktop app to review bilingual AWS-SAA questions one by one.
- Import questions directly from PDF (Chinese + English).
- Offer 4 fixed DeepSeek help buttons plus a custom question input.
- Track learning status per question: Know / DontKnow / Favorite.
- Store and edit the DeepSeek API key locally.

## Non-Goals (MVP)
- Cloud sync, multi-device accounts.
- Advanced analytics dashboards.
- Automated full-quality PDF parsing for every layout without review.

## Recommended Stack (MVP)
- Python 3.11+
- UI: PySide6 (Qt)
- PDF parsing: pdfplumber (plus pypdf as fallback)
- Local storage: SQLite (questions, answers, status, bookmarks)
- Config: JSON file in user profile (API key in clear text)
- HTTP: requests

Rationale: Python has the most robust PDF extraction tooling. PySide6 provides a native Windows UI quickly. SQLite keeps data local and easy to query. This is the fastest path to a working PDF-first MVP.

## Data Model (SQLite)
- table: questions
  - id (integer, pk)
  - q_num (text)
  - stem_en (text)
  - stem_zh (text)
  - options_en (json text)
  - options_zh (json text)
  - correct_answer (text)
  - explanation_en (text)
  - explanation_zh (text)
  - source_doc (text)
  - source_page (integer)

- table: user_status
  - question_id (fk)
  - status (text: Know | DontKnow | Favorite)
  - updated_at (text)

- table: import_jobs
  - id (integer, pk)
  - source_doc (text)
  - created_at (text)
  - notes (text)

## PDF Import Pipeline (MVP)
1. Select Chinese PDF and English PDF.
2. Extract text per page.
3. Segment into questions by regex patterns (e.g., "Question ", "问题"), then normalize.
4. Extract options by label (A/B/C/D/E) per language.
5. Extract answer and explanation blocks.
6. Pair bilingual questions by order index and write to SQLite.
7. Log parse failures (per language) and continue; accept minor losses.
8. Use the other language to compensate where possible when one side fails.

Notes:
- Save source_doc and page numbers for quick debugging.

## UI Layout (MVP)
- Top: Question index, source document, progress.
- Center: Bilingual question stem (EN / ZH).
- Options: Bilingual choices with a toggle to show the correct answer.
- Bottom controls:
  - Previous / Next
  - Status buttons: Know, DontKnow, Favorite
  - Show Answer / Explanation
- Right panel (AI Help):
  - Buttons:
    1) What knowledge is used?
    2) What does this question mean?
    3) Why is this the correct result?
    4) Make it simpler; I did not understand.
  - Custom question input + Ask button

## DeepSeek Integration
- Prompt template includes:
  - Question stem (EN + ZH)
  - Options (EN + ZH)
  - Correct answer (if revealed)
  - Explanation (if available)
- Each fixed button maps to a prebuilt instruction.
- Custom input overrides the instruction.

## Config and Storage
- Config file: %APPDATA%/aws-saa-trainer/config.json
  - deepseek_api_key
  - last_opened_db
- Database file: %APPDATA%/aws-saa-trainer/data.db

## Milestones
1. Skeleton app and navigation
   - Open DB, basic UI, prev/next, status buttons.
2. PDF import MVP
   - Parse, preview, write to DB; handle basic errors.
3. DeepSeek integration
   - Fixed prompts + custom prompt; show responses in UI.
4. UX polish
   - Search by question id, progress summary, lightweight theming.

## Risks and Mitigation
- PDF parsing inaccuracies: log failures, allow re-import; accept small loss rate.
- Bilingual alignment drift: pair by order and provide manual pairing.
- API latency or errors: add retries, display request status.
- Key exposure (clear text): warn in settings and allow quick replace.

## Acceptance Checklist
- Import both PDFs and see correct total question count.
- Navigate questions; status updates persist after restart.
- Show answer and explanation on demand.
- Fixed AI buttons and custom question both return results.
- Configurable API key in settings.

## Implementation Log
- 2026-02-22: Added PDF import CLI and parsing modules under qbank_trainer/.
- 2026-02-22: Updated dependency pin to PySide6 6.10.2 for Python 3.13 compatibility.
- 2026-02-22: Split importer dependencies from UI dependencies to unblock immediate PDF import execution.
- 2026-02-22: Switched importer to pypdf-only extraction to reduce install risk and proceed with automatic import.
- 2026-02-25: One-off importer run completed: inserted 1019 questions (ZH detected 1019, EN detected 800, EN stem missing 219, ZH stem missing 0, answer missing 0). Output files: qbank_trainer/data.db and qbank_trainer/import_once.log.
- 2026-02-25: Added MVP Windows app entry qbank_trainer/quiz_app.py (question navigation, status marking, answer view, DeepSeek 4 quick buttons + custom prompt, editable key settings).
- 2026-02-25: Added environment key support (`DEEPSEEK_API_KEY`) and stored user key in Windows user environment variables.
- 2026-02-25: Updated key loading priority to support `.env` file (`qbank_trainer/.env`) before system environment variable.
- 2026-02-25: Cleared Windows user environment variable for DeepSeek key; runtime now keeps `.env` as primary key source.
- 2026-02-25: Added one-click Windows launcher `run_qbank.bat` and updated quick-start docs.
- 2026-02-25: Fixed DB compatibility in quiz app by auto-creating missing runtime tables (`user_status`, `import_jobs`) when opening existing `data.db`.
- 2026-02-25: Updated AI chat behavior to append user question + AI response, include full AI output history in every request context, add clear-history button/context-menu, and moved `显示答案/解析` button above the answer pane.
