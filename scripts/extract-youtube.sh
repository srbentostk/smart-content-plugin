#!/bin/bash
# Extrai transcrição de vídeo do YouTube usando yt-dlp (gratuito)
# Uso: ./extract-youtube.sh <URL> [idioma]

URL="$1"
LANG="${2:-pt}"
OUTPUT_DIR="/tmp/sofia-extract"

if [ -z "$URL" ]; then
  echo "Uso: ./extract-youtube.sh <URL_DO_VIDEO> [idioma]"
  echo "Idiomas: pt, en, es, etc."
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

VIDEO_ID=$(echo "$URL" | grep -oP '(?:v=|youtu\.be/)([^&?]+)' | head -1)
if [ -z "$VIDEO_ID" ]; then
  VIDEO_ID=$(echo "$URL" | grep -oE '[a-zA-Z0-9_-]{11}')
fi

echo "Extraindo transcrição do vídeo: $VIDEO_ID"
echo "Idioma: $LANG"

# Tentar legendas manuais primeiro, depois auto-geradas
yt-dlp \
  --write-sub \
  --write-auto-sub \
  --sub-lang "$LANG,en" \
  --sub-format "vtt/best" \
  --skip-download \
  --output "$OUTPUT_DIR/$VIDEO_ID" \
  "$URL" 2>/dev/null

# Encontrar arquivo de legenda gerado
SUB_FILE=$(find "$OUTPUT_DIR" -name "${VIDEO_ID}*" -type f | head -1)

if [ -z "$SUB_FILE" ]; then
  echo "ERRO: Não foi possível extrair transcrição."
  echo "Tente colar o roteiro manualmente."
  exit 1
fi

# Limpar VTT para texto puro
if [[ "$SUB_FILE" == *.vtt ]]; then
  # Remove headers, timestamps e tags
  sed -e '/^WEBVTT/d' \
      -e '/^Kind:/d' \
      -e '/^Language:/d' \
      -e '/^$/d' \
      -e '/^[0-9][0-9]:[0-9][0-9]/d' \
      -e '/-->/d' \
      -e 's/<[^>]*>//g' \
      "$SUB_FILE" | \
  awk '!seen[$0]++' > "$OUTPUT_DIR/${VIDEO_ID}_clean.txt"

  echo "Transcrição salva em: $OUTPUT_DIR/${VIDEO_ID}_clean.txt"
  cat "$OUTPUT_DIR/${VIDEO_ID}_clean.txt"
else
  cat "$SUB_FILE"
fi

# Extrair metadados básicos
echo ""
echo "---"
echo "Extraindo metadados..."
yt-dlp --print "%(title)s|||%(channel)s|||%(view_count)s|||%(like_count)s|||%(comment_count)s|||%(upload_date)s" "$URL" 2>/dev/null
