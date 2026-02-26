@echo off
setlocal

set "ROOT_DIR=%~dp0"
set "APP_DIR=%ROOT_DIR%qbank_trainer"
set "VENV_PY=%ROOT_DIR%.venv\Scripts\python.exe"

if exist "%VENV_PY%" (
  set "PYTHON_EXE=%VENV_PY%"
) else (
  set "PYTHON_EXE=python"
)

if not exist "%APP_DIR%\data.db" (
  echo [WARN] %APP_DIR%\data.db not found.
  echo        Please import or prepare the question database first.
)

cd /d "%APP_DIR%"
"%PYTHON_EXE%" quiz_app.py

if errorlevel 1 (
  echo.
  echo [ERROR] Failed to start quiz_app.py
  echo Press any key to close...
  pause >nul
)

endlocal
