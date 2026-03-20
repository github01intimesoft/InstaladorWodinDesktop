@echo off
cd /d %~dp0

echo ================================
echo Gerando instalador (Inno Setup)
echo ================================

set INNO_PATH="Inno Setup 6\ISCC.exe"

:: Verifica se o ISCC existe
if not exist %INNO_PATH% (
    echo.
    echo ❌ ISCC.exe nao encontrado em:
    echo %INNO_PATH%
    pause
    exit /b 1
)

:: Verifica se o .iss existe
if not exist "WodinInstaller.iss" (
    echo.
    echo ❌ Arquivo WodinInstaller.iss nao encontrado!
    pause
    exit /b 1
)

:: Compila
%INNO_PATH% "WodinInstaller.iss"

if %errorlevel% neq 0 (
    echo.
    echo ❌ Erro ao gerar o instalador
    pause
    exit /b %errorlevel%
)

echo.
echo ✅ Instalador gerado com sucesso!

:: Abre a pasta automaticamente
if exist "InstallerOutput" (
    start "" "InstallerOutput"
)

pause