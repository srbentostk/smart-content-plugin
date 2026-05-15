#!/bin/bash
# Sofia 2.0 — Instalador automático
# Uso: curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash
# Ou: dois cliques no arquivo instalar-sofia-mac.command

set -e

clear 2>/dev/null || true

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     Sofia 2.0 — Instalação Automática    ║"
echo "║                                          ║"
echo "║  Relaxe. Vou instalar tudo pra você.     ║"
echo "║  Pode levar uns 5 minutos.               ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Detectar sistema operacional
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *) echo "❌ Sistema não suportado: $OS"; exit 1 ;;
esac

echo "✓ Sistema detectado: $PLATFORM"
echo ""

# Função para verificar se comando existe
has_command() {
  command -v "$1" >/dev/null 2>&1
}

# ─────────────────────────────────────
# 1. Ferramentas de sistema (Homebrew no Mac)
# ─────────────────────────────────────
if [ "$PLATFORM" = "mac" ]; then
  if ! has_command brew; then
    echo "▸ Instalando Homebrew (gerenciador de programas do Mac)..."
    echo "  Isso pode demorar uns 2 minutos. Aguarde..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
    # Adicionar Homebrew ao PATH para esta sessão
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "  ✓ Homebrew instalado"
  else
    echo "✓ Homebrew já instalado"
  fi
fi

# ─────────────────────────────────────
# 2. Node.js
# ─────────────────────────────────────
echo ""
echo "▸ Verificando Node.js..."
if has_command node; then
  echo "  ✓ Node.js já instalado ($(node --version))"
else
  echo "  Instalando Node.js..."
  if [ "$PLATFORM" = "mac" ]; then
    brew install node
  elif [ "$PLATFORM" = "linux" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
  echo "  ✓ Node.js instalado ($(node --version))"
fi

# ─────────────────────────────────────
# 3. Claude Code
# ─────────────────────────────────────
echo ""
echo "▸ Verificando Claude Code..."
if has_command claude; then
  echo "  ✓ Claude Code já instalado"
else
  echo "  Instalando Claude Code..."
  # Tentar instalador nativo primeiro, fallback para npm
  if curl -fsSL https://claude.ai/install.sh 2>/dev/null | bash 2>/dev/null; then
    echo "  ✓ Claude Code instalado (instalador nativo)"
  else
    npm install -g @anthropic-ai/claude-code 2>/dev/null
    echo "  ✓ Claude Code instalado (via npm)"
  fi
fi

# ─────────────────────────────────────
# 4. yt-dlp (extrator de vídeos — grátis)
# ─────────────────────────────────────
echo ""
echo "▸ Verificando yt-dlp..."
if has_command yt-dlp; then
  echo "  ✓ yt-dlp já instalado ($(yt-dlp --version))"
else
  echo "  Instalando yt-dlp..."
  if [ "$PLATFORM" = "mac" ]; then
    brew install yt-dlp
  elif [ "$PLATFORM" = "linux" ]; then
    pip3 install yt-dlp 2>/dev/null || sudo apt-get install -y yt-dlp
  fi
  echo "  ✓ yt-dlp instalado"
fi

# ─────────────────────────────────────
# 5. Instalar plugin Sofia via marketplace
# ─────────────────────────────────────
echo ""
echo "▸ Instalando plugin Sofia..."
PLUGIN_NAME="smart-content-plugin"

if has_command claude; then
  # Atualizar PATH para garantir que claude encontre npm/node
  export PATH="$HOME/.claude/local/bin:$HOME/.local/bin:$PATH"

  if claude plugin install "$PLUGIN_NAME" 2>/dev/null; then
    echo "  ✓ Plugin Sofia instalado via marketplace"
  elif claude plugin install --url "https://github.com/srbentostk/smart-content-plugin" 2>/dev/null; then
    echo "  ✓ Plugin Sofia instalado via GitHub"
  else
    echo "  ⚠ Plugin nao pode ser instalado automaticamente."
    echo "    Abra o Claude e digite: /plugin install $PLUGIN_NAME"
  fi
else
  echo "  ⚠ Claude Code nao encontrado. Instale o plugin manualmente depois."
fi

# ─────────────────────────────────────
# 6. Resultado final
# ─────────────────────────────────────
echo ""
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║                                                  ║"
echo "║   ✅  INSTALAÇÃO COMPLETA!                       ║"
echo "║                                                  ║"
echo "║   Para usar a Sofia:                             ║"
echo "║                                                  ║"
echo "║   1. Abra o Terminal e digite: claude            ║"
echo "║   2. Faca login em claude.ai                     ║"
echo "║   3. Digite:                                     ║"
echo "║      /smart-content-plugin:sofia-setup           ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "Na primeira vez, o Claude vai pedir para voce"
echo "fazer login. Crie uma conta gratis em claude.ai"
echo "se ainda nao tiver."
echo ""

# Perguntar se quer abrir agora (só se estiver em terminal interativo)
if [ -t 0 ] || [ -e /dev/tty ]; then
  read -p "Quer abrir o Claude agora? (s/n) " -n 1 -r REPLY </dev/tty 2>/dev/null || REPLY="n"
  echo ""
  if [[ $REPLY =~ ^[Ss]$ ]]; then
    claude
  fi
fi
