@echo off
:: ============================================
:: קמפיינר 10X — לחצו פעמיים להתקנה
:: ============================================
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/asafyakov/campaigner-10x-skills/main/install.ps1 | iex"
echo.
echo לחצו Enter לסגירה...
pause >nul
