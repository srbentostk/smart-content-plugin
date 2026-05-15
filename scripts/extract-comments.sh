#!/bin/bash
# Extrai comentários de vídeo do YouTube usando yt-dlp
# Uso: ./extract-comments.sh <URL> [max_comments]

URL="$1"
MAX="${2:-20}"
OUTPUT_DIR="/tmp/sofia-extract"

if [ -z "$URL" ]; then
  echo "Uso: ./extract-comments.sh <URL_DO_VIDEO> [max_comments]"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

VIDEO_ID=$(echo "$URL" | grep -oP '(?:v=|youtu\.be/)([^&?]+)' | head -1)
if [ -z "$VIDEO_ID" ]; then
  VIDEO_ID=$(echo "$URL" | grep -oE '[a-zA-Z0-9_-]{11}')
fi

echo "Extraindo top $MAX comentários do vídeo: $VIDEO_ID"

# Extrair comentários com yt-dlp (ordenados por likes)
yt-dlp \
  --write-comments \
  --extractor-args "youtube:comment_sort=top;max_comments=${MAX}" \
  --skip-download \
  --output "$OUTPUT_DIR/$VIDEO_ID" \
  "$URL" 2>/dev/null

# O arquivo .info.json contém os comentários
INFO_FILE="$OUTPUT_DIR/${VIDEO_ID}.info.json"

if [ ! -f "$INFO_FILE" ]; then
  # Tentar padrão alternativo
  INFO_FILE=$(find "$OUTPUT_DIR" -name "*${VIDEO_ID}*.info.json" | head -1)
fi

if [ -z "$INFO_FILE" ] || [ ! -f "$INFO_FILE" ]; then
  echo "ERRO: Não foi possível extrair comentários."
  echo "Pode ser necessário usar YouTube Data API ou Apify."
  exit 1
fi

# Extrair comentários do JSON usando python
python3 -c "
import json, sys

with open('$INFO_FILE', 'r') as f:
    data = json.load(f)

comments = data.get('comments', [])
if not comments:
    print('Nenhum comentário encontrado.')
    sys.exit(0)

# Ordenar por likes
comments.sort(key=lambda c: c.get('like_count', 0), reverse=True)

print(f'Top {min(len(comments), $MAX)} comentários:')
print('---')
for i, c in enumerate(comments[:$MAX], 1):
    author = c.get('author', 'Anônimo')
    text = c.get('text', '')
    likes = c.get('like_count', 0)
    print(f'{i}. [{likes} likes] @{author}')
    print(f'   {text}')
    print()
" 2>/dev/null

if [ $? -ne 0 ]; then
  echo "ERRO ao processar comentários. Arquivo JSON pode estar em formato inesperado."
fi
