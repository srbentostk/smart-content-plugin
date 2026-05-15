---
description: Configura o plugin Sofia 2.0 - verifica dependências, pede API keys, configura output. Use na primeira execução ou quando config.yaml estiver incompleto.
---

# Setup do Sofia 2.0

## REGRA OBRIGATÓRIA: TUDO EM PORTUGUÊS

**TODAS as mensagens, perguntas, explicações, erros e confirmações devem ser escritas em português do Brasil.**
Nunca use inglês em nenhuma interação com o usuário durante o setup. Isso inclui:
- Títulos e subtítulos das perguntas
- Opções de resposta
- Mensagens de status e progresso
- Mensagens de erro e sucesso
- Descrições de ferramentas e funcionalidades

## Fluxo

### 1. Detectar ambiente (silencioso)
Executar sem mostrar ao usuário:
- Verificar OS (macOS, Linux, Windows): `uname -s`
- Verificar se Node.js está instalado: `node --version`
- Verificar se yt-dlp está instalado: `yt-dlp --version`
- Verificar se existe Obsidian Vault: `find ~ -name ".obsidian" -maxdepth 4 -type d 2>/dev/null | head -5`
- Ler config atual se existir: `knowledge/config.yaml`

### 2. Mostrar resultado da verificação
Mostrar ao usuário um resumo claro:

> **Sofia 2.0 — Configuração inicial**
>
> Verifiquei seu computador. Aqui está o resultado:
>
> ✅ Node.js instalado (v22.x)
> ✅ yt-dlp instalado (2025.x)
> ✅ Obsidian Vault encontrado em /caminho/do/vault
>
> ❌ yt-dlp não encontrado (se faltar)

Se yt-dlp não estiver instalado, explicar:
> O yt-dlp é uma ferramenta que extrai o texto falado dos vídeos do YouTube. Preciso dele para funcionar.
>
> Para instalar, cole este comando no Terminal:
> - **Mac:** `brew install yt-dlp`
> - **Linux:** `pip install yt-dlp`
> - **Windows:** `winget install yt-dlp`

### 3. Perguntar sobre Apify (para Instagram/TikTok)
Usar a ferramenta AskUserQuestion com estas opções EM PORTUGUÊS:

Pergunta: "Você tem uma API key do Apify? (Necessário para analisar vídeos do Instagram e TikTok)"

Opções:
- "Sim, tenho uma" → Pedir a key com mensagem: "Cole sua API key do Apify aqui:"
- "Não tenho, quero criar conta" → Mostrar instruções com link direto:
  > Para criar sua conta e pegar a API key:
  > 1. Acesse: **https://console.apify.com/sign-up**
  > 2. Crie sua conta (tem $5 grátis por mês)
  > 3. Depois de criar, acesse: **https://console.apify.com/account/integrations**
  > 4. Copie o token que aparece na seção "Personal API tokens"
  > 5. Cole aqui:
- "Não quero configurar agora" → Pular. Avisar: "Sem o Apify, a Sofia funciona para YouTube mas não consegue pegar comentários do Instagram e TikTok."

### 4. Perguntar sobre YouTube Data API (opcional)
Usar AskUserQuestion EM PORTUGUÊS:

Pergunta: "Quer configurar a YouTube Data API? (Opcional — o yt-dlp já extrai transcrições de graça)"

Opções:
- "Não, usar só o yt-dlp (recomendado)" → Pular
- "Sim, quero configurar" → Mostrar instruções com link direto:
  > Para pegar sua API key do YouTube:
  > 1. Acesse: **https://console.cloud.google.com/apis/library/youtube.googleapis.com**
  > 2. Ative a API clicando em "Ativar"
  > 3. Vá em: **https://console.cloud.google.com/apis/credentials**
  > 4. Clique em "Criar credenciais" → "Chave de API"
  > 5. Copie a chave e cole aqui:

### 5. Configurar onde salvar
Se encontrou Obsidian Vault, sugerir automaticamente:

> Encontrei seu Obsidian Vault em: `/caminho/do/vault`
> Vou salvar as análises e roteiros lá dentro, na pasta `Sofia/`.

Usar AskUserQuestion EM PORTUGUÊS:

Pergunta: "Onde quer que a Sofia salve as análises e roteiros?"

Opções:
- "Obsidian Vault em /caminho/do/vault (recomendado)" → Usar esse caminho
- "Escolher outro local" → Pedir caminho: "Digite o caminho completo da pasta:"

Se NÃO encontrou Obsidian Vault:
> Não encontrei nenhum Obsidian Vault no seu computador.

Perguntar: "Onde quer que a Sofia salve as análises e roteiros?"

Opções:
- "Criar pasta Sofia na área de trabalho" → Usar `~/Desktop/Sofia/`
- "Escolher outro local" → Pedir caminho

### 6. Firecrawl (opcional)
Usar AskUserQuestion EM PORTUGUÊS:

Pergunta: "Quer configurar o Firecrawl para pesquisa auxiliar de páginas web? (Opcional)"

Opções:
- "Não, pular" → Pular
- "Sim, configurar" → Mostrar instruções com link direto:
  > Para pegar sua API key do Firecrawl:
  > 1. Acesse: **https://www.firecrawl.dev/app/api-keys**
  > 2. Crie sua conta se ainda não tem
  > 3. Copie a API key e cole aqui:

### 7. Salvar config
Criar/atualizar `knowledge/config.yaml` com todas as configurações coletadas.
Incluir data do setup e marcar `setup_completo: true`.

### 8. Teste rápido
Executar um teste silencioso:
```bash
yt-dlp --dump-json "https://www.youtube.com/watch?v=dQw4w9WgXcQ" 2>/dev/null | head -1
```
Se funcionar, confirmar. Se falhar, avisar o usuário.

### 9. Mensagem final
Mostrar ao usuário:

> **✅ Sofia 2.0 configurada com sucesso!**
>
> Agora você pode usar estes comandos:
>
> 📊 `/sofia:analisar` + link do vídeo — analisa por que um vídeo funciona
> ✍️ `/sofia:roteiro` — escreve um roteiro para vídeo viral
> 🔍 `/sofia:critica` — avalia um roteiro com honestidade
> 🔧 `/sofia:melhorar` — melhora um roteiro depois da crítica
> 📈 `/sofia:dashboard` — gera um painel visual bonito
> 💾 `/sofia:exportar` — salva tudo em arquivos organizados
>
> **Dica:** comece com `/sofia:analisar` + o link de um vídeo que você admira!

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
