# Conector: YouTube

## Estratégia econômica

### Prioridade 1: yt-dlp (GRÁTIS)
Para a maioria dos casos, yt-dlp resolve sem precisar de API key:
- Extrai transcrição (legendas automáticas/manuais)
- Extrai metadados (título, canal, views, likes, data)
- Extrai comentários (com --write-comments)

### Prioridade 2: YouTube Data API v3 (grátis com quota)
Apenas se yt-dlp não conseguir extrair comentários ordenados:
- 10.000 unidades/dia grátis
- `commentThreads.list` com `order=relevance`: 1 unidade por request
- Suficiente para ~200+ análises/dia

## Instalação do yt-dlp

### macOS
```bash
brew install yt-dlp
```

### Linux
```bash
pip install yt-dlp
# ou
sudo apt install yt-dlp
```

### Windows
```bash
winget install yt-dlp
```

### Verificar
```bash
yt-dlp --version
```

## YouTube Data API (opcional)

### Como ativar
1. Acesse https://console.cloud.google.com
2. Crie novo projeto ou selecione existente
3. APIs & Services → Enable APIs → YouTube Data API v3
4. Credentials → Create API Key
5. Copie a key

### Configurar no Sofia
- Edite `knowledge/config.yaml`
- Cole em `youtube_api_key: "sua-key"`

### Uso para comentários
```bash
curl "https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=VIDEO_ID&order=relevance&maxResults=20&key=API_KEY"
```

## Quando usar cada um

| Necessidade | Ferramenta | Custo |
|-------------|-----------|-------|
| Transcrição | yt-dlp | Grátis |
| Metadados | yt-dlp | Grátis |
| Comentários (básico) | yt-dlp | Grátis |
| Comentários (ordenados por relevância) | YouTube API | Grátis (quota) |
| Thumbnail | yt-dlp ou API | Grátis |
