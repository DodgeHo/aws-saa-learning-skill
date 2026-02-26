# QBank Trainer (MVP Tools)

This folder contains the PDF import tools for the Windows AWS-SAA bilingual QBank trainer.

## Run MVP App (Windows)

```
python quiz_app.py
```

One-click from project root:

```
run_qbank.bat
```

What is included in MVP app:
- Question-by-question review (Prev / Next)
- Status buttons: Know / DontKnow / Favorite
- Show answer and explanations
- 4 DeepSeek quick-help buttons
- Custom question input for DeepSeek
- Editable DeepSeek API key saved to `%APPDATA%/aws-saa-trainer/config.json`

DeepSeek key priority:
- `qbank_trainer/.env` (`DEEPSEEK_API_KEY=...`) (recommended)
- `DEEPSEEK_API_KEY` environment variable
- fallback to `%APPDATA%/aws-saa-trainer/config.json`

## Setup

1) Create a Python 3.11+ environment.
2) Install dependencies:

```
pip install -r requirements.txt
```

Optional UI dependency (later step):

```
pip install -r requirements-ui.txt
```

## Import PDFs into SQLite

```
python -m src.import_cli --pdf-zh "..\题库\AWS认证 SAA-C03 中文真题题库.pdf" --pdf-en "..\题库\AWS SAA-C03 英文 1019Q.pdf" --db "..\qbank_trainer\data.db" --log "..\qbank_trainer\import.log"
```

Notes:
- The importer logs parse failures but continues.
- If one language fails for a question, the other side is still imported.
- Current importer uses pypdf-only extraction for reliability under unstable network setup.

## Packaging & Release

To distribute the QBank Trainer as a standalone Windows application, a PyInstaller build is provided.

1. **Build locally** (requires Python 3.11+ and a virtualenv):
   ```powershell
   & .venv\Scripts\Activate.ps1          # activate your venv
   python -m pip install -r requirements.txt
   python -m pip install pyinstaller
   python -m PyInstaller --onefile --windowed quiz_app.py --name qbank_trainer
   ```
   The resulting `qbank_trainer.exe` will appear in the `dist/` subfolder.

2. **Include data**: the executable does not embed the SQLite database. Copy `data.db` alongside the exe or open a database via the menu after launch.

3. **Release bundle**: package the exe together with a copy of `data.db` (or an empty template) in a ZIP file and upload to GitHub Releases. A sample release script might look like:
   ```powershell
   cd qbank_trainer
   python -m PyInstaller --onefile --windowed quiz_app.py --name qbank_trainer
   cp data.db dist/            # include sample db
   powershell Compress-Archive -Path dist\* -DestinationPath ..\release\qbank_trainer-v1.0.zip
   ```

4. **Run without Python**: users on Win10/11 can simply unzip and double-click `qbank_trainer.exe`.

5. **Updating API key**: use `%APPDATA%\aws-saa-trainer\config.json` or provide a `.env` in the same folder as the exe.

## Troubleshooting

- If the app fails to start, ensure Windows Defender or antivirus did not block the exe.
- On first run the exe may take a few seconds to unpack.

Thank you for trying the QBank Trainer!
