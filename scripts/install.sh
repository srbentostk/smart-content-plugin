#!/bin/bash
# Sofia 2.0 — Instalador automático
# Uso: curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash

set -e

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     Sofia 2.0 — Instalação Automática    ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Detectar sistema operacional
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *) echo "Sistema não suportado: $OS"; exit 1 ;;
esac

echo "Sistema detectado: $PLATFORM"
echo ""

# Função para verificar se comando existe
has_command() {
  command -v "$1" >/dev/null 2>&1
}

# 1. Verificar/instalar Node.js
echo "▸ Verificando Node.js..."
if has_command node; then
  echo "  ✓ Node.js já instalado ($(node --version))"
else
  echo "  ✗ Node.js não encontrado. Instalando..."
  if [ "$PLATFORM" = "mac" ]; then
    if ! has_command brew; then
      echo "  Instalando Homebrew primeiro..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node
  elif [ "$PLATFORM" = "linux" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    echo "  No Windows, baixe o Node.js em: https://nodejs.org"
    echo "  Depois rode este script novamente."
    exit 1
  fi
  echo "  ✓ Node.js instalado ($(node --version))"
fi

# 2. Verificar/instalar Claude Code
echo "▸ Verificando Claude Code..."
if has_command claude; then
  echo "  ✓ Claude Code já instalado"
else
  echo "  Instalando Claude Code..."
  npm install -g @anthropic-ai/claude-code
  echo "  ✓ Claude Code instalado"
fi

# 3. Verificar/instalar yt-dlp
echo "▸ Verificando yt-dlp..."
if has_command yt-dlp; then
  echo "  ✓ yt-dlp já instalado ($(yt-dlp --version))"
else
  echo "  Instalando yt-dlp..."
  if [ "$PLATFORM" = "mac" ]; then
    brew install yt-dlp
  elif [ "$PLATFORM" = "linux" ]; then
    sudo apt-get install -y yt-dlp 2>/dev/null || pip3 install yt-dlp
  else
    pip3 install yt-dlp
  fi
  echo "  ✓ yt-dlp instalado"
fi

# 4. Baixar o plugin Sofia
echo "▸ Baixando Sofia 2.0..."
INSTALL_DIR="$HOME/sofia-2.0"

if [ -d "$INSTALL_DIR" ]; then
  echo "  Pasta já existe. Atualizando..."
  cd "$INSTALL_DIR"
  git pull origin main 2>/dev/null || echo "  (não é um repo git, pulando atualização)"
else
  if has_command git; then
    git clone https://github.com/srbentostk/smart-content-plugin.git "$INSTALL_DIR"
  else
    echo "  Git não encontrado. Baixando como zip..."
    curl -sL https://github.com/srbentostk/smart-content-plugin/archive/main.zip -o /tmp/sofia.zip
    unzip -q /tmp/sofia.zip -d /tmp/
    mv /tmp/smart-content-plugin-main "$INSTALL_DIR"
    rm /tmp/sofia.zip
  fi
fi

echo "  ✓ Sofia 2.0 baixada em: $INSTALL_DIR"

# 5. Tornar scripts executáveis
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null

# 6. Resultado final
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║         ✓ Instalação completa!           ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Para usar a Sofia, abra o Terminal e digite:"
echo ""
echo "  cd $INSTALL_DIR && claude"
echo ""
echo "Depois, dentro do Claude, digite:"
echo "  /sofia-setup     (configurar pela primeira vez)"
echo "  /sofia-analisar  (analisar um vídeo)"
echo "  /sofia-roteiro   (escrever um roteiro)"
echo ""
echo "Dica: Para Instagram com comentários completos,"
echo "configure o Apify (grátis) rodando /sofia-setup."
echo "Para YouTube, tudo funciona 100% grátis."
echo ""
