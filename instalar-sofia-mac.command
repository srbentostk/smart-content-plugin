#!/bin/bash
# ═══════════════════════════════════════════
# Sofia 2.0 — Instalador para Mac
#
# COMO USAR: Dê dois cliques neste arquivo.
# Ele vai abrir uma janela e instalar tudo
# automaticamente. Só espere terminar.
# ═══════════════════════════════════════════

# Ir para a pasta do script
cd "$(dirname "$0")" 2>/dev/null || true

# Baixar e rodar o instalador
curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash

# Manter a janela aberta para o usuário ler
echo ""
echo "Pressione qualquer tecla para fechar esta janela..."
read -n 1 -s </dev/tty
