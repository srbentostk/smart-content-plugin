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
# 5. Git (necessário para baixar o plugin)
# ─────────────────────────────────────
if ! has_command git; then
  echo ""
  echo "▸ Instalando Git..."
  if [ "$PLATFORM" = "mac" ]; then
    # No Mac, xcode-select instala o git
    xcode-select --install 2>/dev/null || true
    # Alternativa via brew
    brew install git 2>/dev/null || true
  elif [ "$PLATFORM" = "linux" ]; then
    sudo apt-get install -y git
  fi
fi

# ─────────────────────────────────────
# 6. Baixar o plugin Sofia
# ─────────────────────────────────────
echo ""
echo "▸ Baixando Sofia 2.0..."
INSTALL_DIR="$HOME/sofia-2.0"

if [ -d "$INSTALL_DIR" ]; then
  echo "  Pasta já existe. Atualizando..."
  cd "$INSTALL_DIR"
  git pull origin main 2>/dev/null || echo "  (atualização manual necessária)"
else
  if has_command git; then
    git clone https://github.com/srbentostk/smart-content-plugin.git "$INSTALL_DIR" 2>/dev/null
  else
    echo "  Baixando como zip..."
    curl -sL https://github.com/srbentostk/smart-content-plugin/archive/main.zip -o /tmp/sofia.zip
    unzip -qo /tmp/sofia.zip -d /tmp/
    mv /tmp/smart-content-plugin-main "$INSTALL_DIR"
    rm -f /tmp/sofia.zip
  fi
fi

echo "  ✓ Sofia 2.0 baixada em: $INSTALL_DIR"

# ─────────────────────────────────────
# 7. Configurar permissões
# ─────────────────────────────────────
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null

# ─────────────────────────────────────
# 8. Resultado final
# ─────────────────────────────────────
echo ""
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║                                              ║"
echo "║   ✅  INSTALAÇÃO COMPLETA!                   ║"
echo "║                                              ║"
echo "║   Para usar a Sofia, cole no Terminal:        ║"
echo "║                                              ║"
echo "║   cd ~/sofia-2.0 && claude                   ║"
echo "║                                              ║"
echo "║   Depois digite:                             ║"
echo "║   /sofia-setup   → configurar                ║"
echo "║   /sofia-analisar → analisar vídeo           ║"
echo "║   /sofia-roteiro  → escrever roteiro         ║"
echo "║                                              ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "Na primeira vez, o Claude vai pedir para você"
echo "fazer login. Crie uma conta grátis em claude.ai"
echo "se ainda não tiver."
echo ""

# Perguntar se quer abrir agora (só se estiver em terminal interativo)
if [ -t 0 ] || [ -e /dev/tty ]; then
  read -p "Quer abrir a Sofia agora? (s/n) " -n 1 -r REPLY </dev/tty 2>/dev/null || REPLY="n"
  echo ""
  if [[ $REPLY =~ ^[Ss]$ ]]; then
    cd "$INSTALL_DIR"
    claude
  fi
fi
