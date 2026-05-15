@echo off
chcp 65001 >nul 2>&1
title Sofia 2.0 - Instalador

echo.
echo ╔══════════════════════════════════════════╗
echo ║     Sofia 2.0 — Instalação Automática    ║
echo ║                                          ║
echo ║  Relaxe. Vou instalar tudo pra você.     ║
echo ║  Pode levar uns 5 minutos.               ║
echo ╚══════════════════════════════════════════╝
echo.

REM Verificar Node.js
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ▸ Node.js não encontrado. Instalando...
    where winget >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
    ) else (
        echo ❌ Não foi possível instalar automaticamente.
        echo    Baixe o Node.js em: https://nodejs.org
        echo    Instale, feche esta janela e rode de novo.
        pause
        exit /b 1
    )
    echo   ✓ Node.js instalado
) else (
    echo ✓ Node.js já instalado
)

REM Verificar Claude Code
where claude >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ▸ Instalando Claude Code...
    call npm install -g @anthropic-ai/claude-code
    echo   ✓ Claude Code instalado
) else (
    echo ✓ Claude Code já instalado
)

REM Verificar yt-dlp
where yt-dlp >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ▸ Instalando yt-dlp...
    where winget >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        winget install yt-dlp --accept-package-agreements --accept-source-agreements
    ) else (
        call pip install yt-dlp
    )
    echo   ✓ yt-dlp instalado
) else (
    echo ✓ yt-dlp já instalado
)

REM Baixar plugin
echo.
echo ▸ Baixando Sofia 2.0...
set INSTALL_DIR=%USERPROFILE%\sofia-2.0

if exist "%INSTALL_DIR%" (
    echo   Pasta já existe. Atualizando...
    cd /d "%INSTALL_DIR%"
    git pull origin main 2>nul
) else (
    where git >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        git clone https://github.com/srbentostk/smart-content-plugin.git "%INSTALL_DIR%"
    ) else (
        echo   Git não encontrado. Baixando como zip...
        curl -sL https://github.com/srbentostk/smart-content-plugin/archive/main.zip -o "%TEMP%\sofia.zip"
        powershell -Command "Expand-Archive -Path '%TEMP%\sofia.zip' -DestinationPath '%TEMP%\sofia-extract' -Force"
        move "%TEMP%\sofia-extract\smart-content-plugin-main" "%INSTALL_DIR%" >nul
        del "%TEMP%\sofia.zip" >nul 2>&1
        rmdir /s /q "%TEMP%\sofia-extract" >nul 2>&1
    )
)
echo   ✓ Sofia 2.0 baixada em: %INSTALL_DIR%

echo.
echo.
echo ╔══════════════════════════════════════════════╗
echo ║                                              ║
echo ║   ✅  INSTALAÇÃO COMPLETA!                   ║
echo ║                                              ║
echo ║   Para usar a Sofia:                         ║
echo ║                                              ║
echo ║   1. Abra o PowerShell                       ║
echo ║   2. Digite: cd ~/sofia-2.0                  ║
echo ║   3. Digite: claude                          ║
echo ║                                              ║
echo ║   Depois digite:                             ║
echo ║   /sofia-setup   → configurar                ║
echo ║   /sofia-analisar → analisar vídeo           ║
echo ║   /sofia-roteiro  → escrever roteiro         ║
echo ║                                              ║
echo ╚══════════════════════════════════════════════╝
echo.
echo Na primeira vez, o Claude vai pedir para você
echo fazer login. Crie uma conta grátis em claude.ai
echo.

set /p REPLY="Quer abrir a Sofia agora? (s/n) "
if /i "%REPLY%"=="s" (
    cd /d "%INSTALL_DIR%"
    claude
) else (
    pause
)
