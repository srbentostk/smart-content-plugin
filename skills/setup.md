---
name: sofia-setup
description: Configura o plugin Sofia 2.0 - verifica dependências, pede API keys, configura output. Use na primeira execução ou quando config.yaml estiver incompleto.
---

# Setup do Sofia 2.0

## Fluxo

### 1. Detectar ambiente
- Verificar se está rodando em Claude Code, Gemini CLI, ou outro
- Verificar OS (macOS, Linux, Windows)
- Verificar se Node.js está instalado: `node --version`

### 2. Verificar yt-dlp
```bash
yt-dlp --version
```
Se não instalado:
- macOS: `brew install yt-dlp`
- Linux: `pip install yt-dlp`
- Windows: `winget install yt-dlp`

Explicar: "yt-dlp é usado para extrair transcrições do YouTube gratuitamente, sem precisar de API key."

### 3. Configurar Apify (obrigatório para Instagram/TikTok)
Perguntar ao usuário:
> "Para analisar vídeos do Instagram e TikTok, preciso de uma API key do Apify.
> 1. Crie conta grátis em https://apify.com
> 2. Vá em Settings → Integrations → API Token
> 3. Cole sua API key aqui:"

Salvar em `knowledge/config.yaml` como `apify_api_key`.

### 4. YouTube Data API (opcional)
Perguntar:
> "Quer configurar YouTube Data API para extrair comentários? (Opcional - yt-dlp já extrai transcrição)
> Se sim: https://console.cloud.google.com → APIs → YouTube Data API v3 → Criar credencial"

Se não, usar fallback com yt-dlp para comentários também.

### 5. Configurar output path
Detectar automaticamente se está dentro de um Obsidian Vault:
```bash
find . -name ".obsidian" -maxdepth 3
```
Se encontrar, sugerir path relativo. Se não, perguntar:
> "Onde quer que eu salve as análises e roteiros? (caminho completo)"

### 6. Firecrawl (opcional)
> "Quer configurar Firecrawl para scraping auxiliar de páginas web? (Opcional)"

### 7. Salvar config
Criar `knowledge/config.yaml` com todas as configurações.

### 8. Testar
- Testar yt-dlp com um vídeo curto do YouTube
- Testar Apify com uma chamada simples
- Confirmar que output path é gravável

### 9. Concluir
> "Sofia 2.0 configurada com sucesso! Comandos disponíveis:
> - /sofia-analisar [links] — analisa vídeos
> - /sofia-roteiro — escreve roteiro guiado
> - /sofia-critica — critica um roteiro
> - /sofia-dashboard — gera dashboard de conhecimentos"

## Config template

```yaml
sofia:
  apify_api_key: ""
  youtube_api_key: ""
  firecrawl_api_key: ""
  obsidian_vault_path: ""
  output_format: "obsidian"
  ambiente: "claude-code"
  setup_completo: true
  data_setup: ""
```
