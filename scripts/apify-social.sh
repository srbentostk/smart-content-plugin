#!/bin/bash
# Wrapper para Apify actors — extrai dados de Instagram e TikTok
# Uso: ./apify-social.sh <platform> <url> [api_key]
# Requer: APIFY_API_KEY no ambiente ou em config.yaml

PLATFORM="$1"
URL="$2"
API_KEY="${3:-$APIFY_API_KEY}"

if [ -z "$PLATFORM" ] || [ -z "$URL" ]; then
  echo "Uso: ./apify-social.sh <instagram|tiktok> <URL> [api_key]"
  echo ""
  echo "Exemplos:"
  echo "  ./apify-social.sh instagram https://www.instagram.com/reel/ABC123/"
  echo "  ./apify-social.sh tiktok https://www.tiktok.com/@user/video/123456"
  exit 1
fi

# Tentar carregar API key do config se não fornecida
if [ -z "$API_KEY" ]; then
  CONFIG_FILE="$(dirname "$0")/../knowledge/config.yaml"
  if [ -f "$CONFIG_FILE" ]; then
    API_KEY=$(grep "apify_api_key" "$CONFIG_FILE" | cut -d'"' -f2)
  fi
fi

if [ -z "$API_KEY" ]; then
  echo "ERRO: APIFY_API_KEY não configurada."
  echo "Execute /sofia-setup ou defina APIFY_API_KEY no ambiente."
  exit 1
fi

OUTPUT_DIR="/tmp/sofia-extract"
mkdir -p "$OUTPUT_DIR"

case "$PLATFORM" in
  instagram)
    echo "Extraindo dados do Instagram via Apify..."
    echo "URL: $URL"
    echo ""
    echo "--- INSTRUÇÃO PARA O AGENTE ---"
    echo "Use o Apify MCP com os seguintes actors:"
    echo ""
    echo "Para transcrição/conteúdo do post:"
    echo "  Actor: apify/instagram-scraper"
    echo "  Input: { \"directUrls\": [\"$URL\"], \"resultsLimit\": 1 }"
    echo ""
    echo "Para comentários:"
    echo "  Actor: apify/instagram-comment-scraper"
    echo "  Input: { \"directUrls\": [\"$URL\"], \"resultsLimit\": 20, \"sort\": \"top\" }"
    echo ""
    echo "API Key: ${API_KEY:0:10}..."
    ;;

  tiktok)
    echo "Extraindo dados do TikTok via Apify..."
    echo "URL: $URL"
    echo ""
    echo "--- INSTRUÇÃO PARA O AGENTE ---"
    echo "Use o Apify MCP com os seguintes actors:"
    echo ""
    echo "Para conteúdo do vídeo:"
    echo "  Actor: clockworks/tiktok-scraper"
    echo "  Input: { \"postURLs\": [\"$URL\"], \"resultsPerPage\": 1 }"
    echo ""
    echo "Para comentários:"
    echo "  Actor: clockworks/tiktok-comments-scraper"
    echo "  Input: { \"postURLs\": [\"$URL\"], \"maxItems\": 20 }"
    echo ""
    echo "API Key: ${API_KEY:0:10}..."
    ;;

  *)
    echo "Plataforma não suportada: $PLATFORM"
    echo "Use: instagram ou tiktok"
    exit 1
    ;;
esac
