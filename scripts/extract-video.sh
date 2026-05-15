#!/bin/bash
# Sofia 2.0 — Extração universal de vídeo (qualquer plataforma)
# Usa yt-dlp que suporta YouTube, Instagram, TikTok, Twitter/X e milhares de outros sites
# Uso: ./extract-video.sh <URL> [idioma]

URL="$1"
LANG="${2:-pt}"
OUTPUT_DIR="/tmp/sofia-extract"

if [ -z "$URL" ]; then
  echo "Uso: ./extract-video.sh <URL_DO_VIDEO> [idioma]"
  echo ""
  echo "Funciona com: YouTube, Instagram, TikTok, Twitter/X, Reddit, e mais"
  echo "Extrai: transcrição, metadados, comentários, thumbnail"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Gerar ID único para o arquivo
VIDEO_ID=$(echo "$URL" | md5sum 2>/dev/null | cut -c1-12 || echo "$URL" | md5 | cut -c1-12)

echo "═══════════════════════════════════════"
echo " Sofia 2.0 — Extração de Vídeo"
echo "═══════════════════════════════════════"
echo "URL: $URL"
echo "Idioma: $LANG"
echo ""

# 1. Extrair metadados (título, canal, views, likes, etc.)
echo "▸ Extraindo metadados..."
METADATA=$(yt-dlp --print "%(title)s|||%(channel)s|||%(view_count)s|||%(like_count)s|||%(comment_count)s|||%(upload_date)s|||%(description)s|||%(duration)s|||%(webpage_url)s" "$URL" 2>/dev/null)

if [ -z "$METADATA" ]; then
  echo "  ✗ Não foi possível extrair metadados."
  echo "  O vídeo pode ser privado ou a plataforma não é suportada."
  exit 1
fi

echo "  ✓ Metadados extraídos"
echo "$METADATA" > "$OUTPUT_DIR/${VIDEO_ID}_metadata.txt"

# Mostrar metadados
IFS='|||' read -r TITLE CHANNEL VIEWS LIKES COMMENTS DATE DESC DURATION PAGE_URL <<< "$METADATA"
echo "  Título: $TITLE"
echo "  Canal: $CHANNEL"
echo "  Views: $VIEWS | Likes: $LIKES | Comentários: $COMMENTS"
echo ""

# 2. Extrair transcrição/legendas
echo "▸ Extraindo transcrição..."
yt-dlp \
  --write-sub \
  --write-auto-sub \
  --sub-lang "$LANG,en" \
  --sub-format "vtt/best" \
  --skip-download \
  --output "$OUTPUT_DIR/${VIDEO_ID}" \
  "$URL" 2>/dev/null

SUB_FILE=$(find "$OUTPUT_DIR" -name "${VIDEO_ID}*" -name "*.vtt" -type f 2>/dev/null | head -1)

if [ -n "$SUB_FILE" ]; then
  # Limpar VTT para texto puro
  sed -e '/^WEBVTT/d' \
      -e '/^Kind:/d' \
      -e '/^Language:/d' \
      -e '/^$/d' \
      -e '/^[0-9][0-9]:[0-9][0-9]/d' \
      -e '/-->/d' \
      -e 's/<[^>]*>//g' \
      "$SUB_FILE" | \
  awk '!seen[$0]++' > "$OUTPUT_DIR/${VIDEO_ID}_transcricao.txt"
  echo "  ✓ Transcrição extraída"
else
  echo "  ✗ Sem legendas disponíveis (vídeo pode não ter transcrição automática)"
  echo "  Tentando baixar áudio para transcrição manual..."
  # Baixar apenas áudio para possível transcrição via Whisper
  yt-dlp -x --audio-format mp3 --output "$OUTPUT_DIR/${VIDEO_ID}_audio.%(ext)s" "$URL" 2>/dev/null
  if [ -f "$OUTPUT_DIR/${VIDEO_ID}_audio.mp3" ]; then
    echo "  ✓ Áudio baixado (pode ser transcrito com Whisper)"
  else
    echo "  ✗ Também não foi possível baixar áudio"
  fi
fi

# 3. Extrair comentários
echo ""
echo "▸ Extraindo comentários..."
yt-dlp \
  --write-comments \
  --extractor-args "youtube:comment_sort=top;max_comments=20" \
  --skip-download \
  --output "$OUTPUT_DIR/${VIDEO_ID}_comments" \
  "$URL" 2>/dev/null

COMMENTS_FILE=$(find "$OUTPUT_DIR" -name "*${VIDEO_ID}_comments*.info.json" -type f 2>/dev/null | head -1)

if [ -n "$COMMENTS_FILE" ] && [ -f "$COMMENTS_FILE" ]; then
  python3 -c "
import json, sys
with open('$COMMENTS_FILE', 'r') as f:
    data = json.load(f)
comments = data.get('comments', [])
if not comments:
    print('  ✗ Nenhum comentário encontrado')
    sys.exit(0)
comments.sort(key=lambda c: c.get('like_count', 0), reverse=True)
print(f'  ✓ {len(comments)} comentários extraídos')
output = []
for c in comments[:20]:
    output.append({'texto': c.get('text',''), 'likes': c.get('like_count',0), 'autor': c.get('author','')})
with open('$OUTPUT_DIR/${VIDEO_ID}_comentarios.json', 'w') as f:
    json.dump(output, f, ensure_ascii=False, indent=2)
" 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "  ✗ Comentários não disponíveis via yt-dlp para esta plataforma"
    echo "  (Use Apify como fallback para Instagram/TikTok)"
  fi
else
  echo "  ✗ Comentários não disponíveis via yt-dlp para esta plataforma"
  echo "  (Use Apify como fallback para Instagram/TikTok)"
fi

# 4. Extrair thumbnail
echo ""
echo "▸ Extraindo thumbnail..."
yt-dlp --write-thumbnail --skip-download --output "$OUTPUT_DIR/${VIDEO_ID}_thumb" "$URL" 2>/dev/null
THUMB_FILE=$(find "$OUTPUT_DIR" -name "${VIDEO_ID}_thumb*" -not -name "*.json" -not -name "*.vtt" -not -name "*.txt" -type f 2>/dev/null | head -1)
if [ -n "$THUMB_FILE" ]; then
  echo "  ✓ Thumbnail salva: $THUMB_FILE"
else
  echo "  ✗ Thumbnail não disponível"
fi

# 5. Resumo
echo ""
echo "═══════════════════════════════════════"
echo " Extração completa"
echo "═══════════════════════════════════════"
echo "Arquivos em: $OUTPUT_DIR/"
echo ""
ls -la "$OUTPUT_DIR/${VIDEO_ID}"* 2>/dev/null
echo ""
