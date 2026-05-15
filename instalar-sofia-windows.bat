@echo off
chcp 65001 >nul 2>&1
title Sofia 2.0 - Instalador

set PLUGIN_NAME=sofia
set REPO_URL=https://github.com/srbentostk/smart-content-plugin

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
        echo    Não foi possível instalar automaticamente.
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

REM Instalar plugin Sofia
echo.
echo ▸ Instalando plugin Sofia...

where claude >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    claude plugin install %PLUGIN_NAME% >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo   ✓ Plugin Sofia instalado via marketplace
    ) else (
        echo   Marketplace indisponivel, tentando via GitHub...
        claude plugin marketplace add %REPO_URL% >nul 2>&1
        claude plugin install %PLUGIN_NAME% >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            echo   ✓ Plugin Sofia instalado via GitHub
        ) else (
            echo   Plugin nao pode ser instalado automaticamente.
            echo   Abra o Claude e digite: /plugin install sofia
        )
    )
) else (
    echo   Claude Code nao encontrado. Instale o plugin manualmente depois.
)

echo.
echo.
echo ╔══════════════════════════════════════════════════╗
echo ║                                                  ║
echo ║   ✅  INSTALAÇÃO COMPLETA!                       ║
echo ║                                                  ║
echo ║   Para usar a Sofia:                             ║
echo ║                                                  ║
echo ║   1. Abra o app Claude                           ║
echo ║      (baixe em claude.ai/download)               ║
echo ║   2. Faca login com sua conta                    ║
echo ║   3. Na aba Code ou Cowork, digite:              ║
echo ║      /sofia:setup                                ║
echo ║                                                  ║
echo ╚══════════════════════════════════════════════════╝
echo.
echo Na primeira vez, o Claude vai pedir para voce
echo fazer login. Crie uma conta gratis em claude.ai
echo.

set /p REPLY="Quer abrir o Claude agora? (s/n) "
if /i "%REPLY%"=="s" (
    REM Tentar abrir o app Claude Desktop primeiro, fallback para CLI
    if exist "%LOCALAPPDATA%\Programs\Claude\Claude.exe" (
        start "" "%LOCALAPPDATA%\Programs\Claude\Claude.exe"
    ) else (
        claude
    )
) else (
    pause
)
