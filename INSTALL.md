# Installation Instructions

This document explains how to set up the AWS-SAA Learning Skill and the QBank Trainer tool.

## 1. AWS-SAA Learning Skill

1. Clone or download the repository:
   ```bash
   git clone https://github.com/DodgeHo/aws-saa-learning-skill.git
   ```
2. Place course subtitles and materials in the `translations/` directory as described in the main `README.md`.
3. (Optional) Create an [Obsidian](https://obsidian.md/) vault and install the recommended spaced repetition plugin.
4. Use the interactive commands (`开始学习`, `学习 章节名`, etc.) via your preferred interface.

No additional dependencies are required for the learning skill itself; it is primarily a collection of markdown and supporting scripts.

## 2. QBank Trainer Tool (题库背题工具)

You can choose between two modes:

### 2.1 Standalone Windows Executable (Recommended)

1. Download the latest release `.zip` from GitHub Releases: https://github.com/DodgeHo/aws-saa-learning-skill/releases
2. Extract the archive; it contains `qbank_trainer.exe` and a sample `data.db`.
3. Double-click `qbank_trainer.exe` to run. No Python installation is needed.

### 2.2 From Source (Python Required)

1. Ensure Python 3.11+ is installed and available in your PATH.
2. (Optional) create a virtual environment:
   ```powershell
   python -m venv .venv
   & .venv\Scripts\Activate.ps1
   ```
3. Install dependencies:
   ```bash
   pip install -r qbank_trainer/requirements.txt
   pip install -r qbank_trainer/requirements-ui.txt   # for optional UI
   ```
4. Run the trainer:
   ```bash
   python qbank_trainer/quiz_app.py
   ```

### 2.3 Importing Question Bank

Use the PDF import script (requires `pypdf` and `requests`):

```bash
python -m qbank_trainer.src.import_cli \
  --pdf-zh "题库/AWS认证 SAA-C03 中文真题题库.pdf" \
  --pdf-en "题库/AWS SAA-C03 英文 1019Q.pdf" \
  --db "qbank_trainer/data.db"
```

## 3. Environment Variables

- `DEEPSEEK_API_KEY`: provide an API key for AI assistance.
- Alternatively place a `.env` file inside `qbank_trainer` with `DEEPSEEK_API_KEY=...`.

For more details see `qbank_trainer/README.md`.
