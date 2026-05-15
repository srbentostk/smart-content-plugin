#!/bin/bash
# Sofia 2.0 — Instalador automático
# Uso: curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash
# Ou: dois cliques no arquivo instalar-sofia-mac.command

set -e

PLUGIN_NAME="sofia"
REPO_URL="https://github.com/srbentostk/smart-content-plugin"
LOG="/tmp/sofia-install.log"

clear 2>/dev/null || true

echo "" | tee "$LOG"
echo "╔══════════════════════════════════════════╗" | tee -a "$LOG"
echo "║     Sofia 2.0 — Instalação Automática    ║" | tee -a "$LOG"
echo "║                                          ║" | tee -a "$LOG"
echo "║  Relaxe. Vou instalar tudo pra você.     ║" | tee -a "$LOG"
echo "║  Pode levar uns 5 minutos.               ║" | tee -a "$LOG"
echo "╚══════════════════════════════════════════╝" | tee -a "$LOG"
echo "" | tee -a "$LOG"

OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *) echo "Sistema não suportado: $OS" | tee -a "$LOG"; exit 1 ;;
esac

echo "Sistema detectado: $PLATFORM" | tee -a "$LOG"
echo "" | tee -a "$LOG"

has_command() {
  command -v "$1" >/dev/null 2>&1
}

ERRORS=()

# ─────────────────────────────────────
# 1. Ferramentas de sistema (Homebrew no Mac)
# ─────────────────────────────────────
if [ "$PLATFORM" = "mac" ]; then
  if ! has_command brew; then
    echo "▸ Instalando Homebrew..." | tee -a "$LOG"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null >> "$LOG" 2>&1
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "  ✓ Homebrew instalado" | tee -a "$LOG"
  else
    echo "✓ Homebrew já instalado" | tee -a "$LOG"
  fi
fi

# ─────────────────────────────────────
# 2. Node.js
# ─────────────────────────────────────
echo "" | tee -a "$LOG"
echo "▸ Verificando Node.js..." | tee -a "$LOG"
if has_command node; then
  echo "  ✓ Node.js já instalado ($(node --version))" | tee -a "$LOG"
else
  echo "  Instalando Node.js..." | tee -a "$LOG"
  if [ "$PLATFORM" = "mac" ]; then
    brew install node >> "$LOG" 2>&1
  elif [ "$PLATFORM" = "linux" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - >> "$LOG" 2>&1
    sudo apt-get install -y nodejs >> "$LOG" 2>&1
  fi
  if has_command node; then
    echo "  ✓ Node.js instalado ($(node --version))" | tee -a "$LOG"
  else
    ERRORS+=("Node.js nao pode ser instalado. Baixe em: nodejs.org")
  fi
fi

# ─────────────────────────────────────
# 3. Claude Code
# ─────────────────────────────────────
echo "" | tee -a "$LOG"
echo "▸ Verificando Claude Code..." | tee -a "$LOG"
if has_command claude; then
  echo "  ✓ Claude Code já instalado" | tee -a "$LOG"
else
  echo "  Instalando Claude Code..." | tee -a "$LOG"
  if curl -fsSL https://claude.ai/install.sh 2>/dev/null | bash >> "$LOG" 2>&1; then
    echo "  ✓ Claude Code instalado (instalador nativo)" | tee -a "$LOG"
  elif has_command npm; then
    npm install -g @anthropic-ai/claude-code >> "$LOG" 2>&1
    echo "  ✓ Claude Code instalado (via npm)" | tee -a "$LOG"
  fi
  export PATH="$HOME/.local/bin:$HOME/.claude/local/bin:$PATH"
  if ! has_command claude; then
    ERRORS+=("Claude Code nao pode ser instalado")
  fi
fi

# ─────────────────────────────────────
# 4. yt-dlp (extrator de vídeos — grátis)
# ─────────────────────────────────────
echo "" | tee -a "$LOG"
echo "▸ Verificando yt-dlp..." | tee -a "$LOG"
if has_command yt-dlp; then
  echo "  ✓ yt-dlp já instalado ($(yt-dlp --version))" | tee -a "$LOG"
else
  echo "  Instalando yt-dlp..." | tee -a "$LOG"
  if [ "$PLATFORM" = "mac" ]; then
    brew install yt-dlp >> "$LOG" 2>&1
  elif [ "$PLATFORM" = "linux" ]; then
    pip3 install yt-dlp >> "$LOG" 2>&1 || sudo apt-get install -y yt-dlp >> "$LOG" 2>&1
  fi
  if has_command yt-dlp; then
    echo "  ✓ yt-dlp instalado" | tee -a "$LOG"
  else
    ERRORS+=("yt-dlp nao pode ser instalado")
  fi
fi

# ─────────────────────────────────────
# 5. Instalar plugin Sofia via Claude Code
# ─────────────────────────────────────
echo "" | tee -a "$LOG"
echo "▸ Instalando plugin Sofia..." | tee -a "$LOG"

if has_command claude; then
  echo "Installing plugin \"$PLUGIN_NAME\"..." >> "$LOG"

  if claude plugin install "$PLUGIN_NAME" >> "$LOG" 2>&1; then
    echo "  ✓ Plugin Sofia instalado via marketplace" | tee -a "$LOG"
  else
    echo "Plugin Sofia: marketplace falhou, tentando via GitHub..." >> "$LOG"
    if claude plugin marketplace add "$REPO_URL" >> "$LOG" 2>&1 && \
       claude plugin install "$PLUGIN_NAME" >> "$LOG" 2>&1; then
      echo "  ✓ Plugin Sofia instalado via GitHub" | tee -a "$LOG"
    else
      ERRORS+=("Plugin Sofia nao pode ser instalado automaticamente. Abra o Claude e digite: /plugin install sofia")
    fi
  fi
else
  ERRORS+=("Claude Code nao disponivel para instalar o plugin")
fi

# ─────────────────────────────────────
# 6. Resultado final
# ─────────────────────────────────────
echo "" | tee -a "$LOG"
echo "" | tee -a "$LOG"

if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "╔══════════════════════════════════════════════════╗" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "║   ✅  INSTALAÇÃO COMPLETA!                       ║" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "║   Para usar a Sofia:                             ║" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "║   1. Abra o Terminal e digite: claude            ║" | tee -a "$LOG"
  echo "║   2. Na primeira vez, faça login em claude.ai    ║" | tee -a "$LOG"
  echo "║   3. Depois digite:                              ║" | tee -a "$LOG"
  echo "║      /sofia:setup                                ║" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "╚══════════════════════════════════════════════════╝" | tee -a "$LOG"
else
  echo "╔══════════════════════════════════════════════════╗" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "║   ⚠️  INSTALAÇÃO PARCIAL                         ║" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "║   Alguns itens não puderam ser instalados.       ║" | tee -a "$LOG"
  echo "║   Consulte o log: /tmp/sofia-install.log         ║" | tee -a "$LOG"
  echo "║                                                  ║" | tee -a "$LOG"
  echo "╚══════════════════════════════════════════════════╝" | tee -a "$LOG"
  echo "" | tee -a "$LOG"
  echo "Itens com problema:" | tee -a "$LOG"
  for err in "${ERRORS[@]}"; do
    echo "  • $err" | tee -a "$LOG"
  done
fi

echo "" | tee -a "$LOG"
echo "Na primeira vez, o Claude vai pedir para você" | tee -a "$LOG"
echo "fazer login. Crie uma conta grátis em claude.ai" | tee -a "$LOG"
echo "se ainda não tiver." | tee -a "$LOG"
echo "" | tee -a "$LOG"

if [ -t 0 ] || [ -e /dev/tty ]; then
  read -p "Quer abrir o Claude agora? (s/n) " -n 1 -r REPLY </dev/tty 2>/dev/null || REPLY="n"
  echo ""
  if [[ $REPLY =~ ^[Ss]$ ]]; then
    claude
  fi
fi
