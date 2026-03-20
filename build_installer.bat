@echo off
cd /d %~dp0

echo ================================
echo Gerando instalador (Inno Setup)
echo ================================

set INNO_PATH="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

%INNO_PATH% WodinInstaller.iss

if %errorlevel% neq 0 (
    echo.
    echo ❌ Erro ao gerar o instalador
    pause
    exit /b %errorlevel%
)

echo.
echo ✅ Instalador gerado com sucesso!
pause