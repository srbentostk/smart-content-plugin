# ═══════════════════════════════════════════
# Sofia 2.0 — Instalador Visual para Windows
# Interface grafica com barra de progresso.
# Nenhuma janela preta aparece.
# ═══════════════════════════════════════════

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$PLUGIN_NAME = "sofia"

# ─────────────────────────────────────
# Criar janela principal
# ─────────────────────────────────────

$form = New-Object System.Windows.Forms.Form
$form.Text = "Sofia 2.0 — Instalador"
$form.Size = New-Object System.Drawing.Size(520, 400)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 27)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9)

# Titulo
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "Sofia 2.0"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::FromArgb(255, 77, 0)
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(30, 20)
$form.Controls.Add($lblTitle)

# Subtitulo
$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Instalador Automatico"
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$lblSub.ForeColor = [System.Drawing.Color]::FromArgb(161, 161, 170)
$lblSub.AutoSize = $true
$lblSub.Location = New-Object System.Drawing.Point(30, 58)
$form.Controls.Add($lblSub)

# Descricao
$lblDesc = New-Object System.Windows.Forms.Label
$lblDesc.Text = "Vou preparar seu computador com tudo que precisa:`n`n  Node.js  |  Claude Code  |  yt-dlp  |  Plugin Sofia`n`nLeva uns 5 minutos. Voce nao precisa fazer nada."
$lblDesc.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$lblDesc.ForeColor = [System.Drawing.Color]::FromArgb(200, 200, 200)
$lblDesc.Size = New-Object System.Drawing.Size(440, 75)
$lblDesc.Location = New-Object System.Drawing.Point(30, 95)
$form.Controls.Add($lblDesc)

# Status
$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Text = "Clique em Instalar para comecar."
$lblStatus.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$lblStatus.Size = New-Object System.Drawing.Size(440, 25)
$lblStatus.Location = New-Object System.Drawing.Point(30, 185)
$form.Controls.Add($lblStatus)

# Barra de progresso
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Size = New-Object System.Drawing.Size(440, 28)
$progressBar.Location = New-Object System.Drawing.Point(30, 215)
$progressBar.Style = "Continuous"
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$form.Controls.Add($progressBar)

# Detalhe
$lblDetail = New-Object System.Windows.Forms.Label
$lblDetail.Text = ""
$lblDetail.Font = New-Object System.Drawing.Font("Consolas", 8)
$lblDetail.ForeColor = [System.Drawing.Color]::FromArgb(113, 113, 122)
$lblDetail.Size = New-Object System.Drawing.Size(440, 50)
$lblDetail.Location = New-Object System.Drawing.Point(30, 250)
$form.Controls.Add($lblDetail)

# Botao Instalar
$btnInstall = New-Object System.Windows.Forms.Button
$btnInstall.Text = "Instalar"
$btnInstall.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnInstall.Size = New-Object System.Drawing.Size(130, 42)
$btnInstall.Location = New-Object System.Drawing.Point(340, 310)
$btnInstall.BackColor = [System.Drawing.Color]::FromArgb(255, 77, 0)
$btnInstall.ForeColor = [System.Drawing.Color]::White
$btnInstall.FlatStyle = "Flat"
$btnInstall.FlatAppearance.BorderSize = 0
$btnInstall.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnInstall)

# Botao Cancelar
$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$btnCancel.Size = New-Object System.Drawing.Size(100, 42)
$btnCancel.Location = New-Object System.Drawing.Point(230, 310)
$btnCancel.FlatStyle = "Flat"
$btnCancel.ForeColor = [System.Drawing.Color]::FromArgb(161, 161, 170)
$btnCancel.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(46, 46, 54)
$btnCancel.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnCancel)

$btnCancel.Add_Click({ $form.Close() })

# ─────────────────────────────────────
# Funcoes auxiliares
# ─────────────────────────────────────

function Update-UI($statusText, $detailText, $progressValue) {
    $lblStatus.Text = $statusText
    $lblDetail.Text = $detailText
    $progressBar.Value = $progressValue
    $form.Refresh()
    [System.Windows.Forms.Application]::DoEvents()
}

function Test-CommandExists($cmd) {
    $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue)
}

function Run-Silent($exe, $arguments) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $exe
    $psi.Arguments = $arguments
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $process = [System.Diagnostics.Process]::Start($psi)
    $process.WaitForExit()
    return $process.ExitCode
}

# ─────────────────────────────────────
# Logica de instalacao
# ─────────────────────────────────────

$btnInstall.Add_Click({
    $btnInstall.Enabled = $false
    $btnCancel.Enabled = $false
    $errors = @()

    # Refresh PATH para detectar programas recem-instalados
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    # ── 1. Node.js ──
    Update-UI "Passo 1 de 4: Verificando Node.js..." "" 10

    if (-not (Test-CommandExists "node")) {
        Update-UI "Passo 1 de 4: Instalando Node.js..." "Isso pode levar uns 2 minutos..." 15

        if (Test-CommandExists "winget") {
            $exitCode = Run-Silent "winget" "install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent"
            # Refresh PATH
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        }

        if (-not (Test-CommandExists "node")) {
            $errors += "Node.js nao pode ser instalado. Baixe em: nodejs.org"
        }
    }

    if (Test-CommandExists "node") {
        Update-UI "Passo 1 de 4: Node.js instalado" "$(node --version)" 25
    }

    # ── 2. Claude Code ──
    Update-UI "Passo 2 de 4: Verificando Claude Code..." "" 30

    if (-not (Test-CommandExists "claude")) {
        Update-UI "Passo 2 de 4: Instalando Claude Code..." "npm install -g @anthropic-ai/claude-code" 35

        if (Test-CommandExists "npm") {
            Run-Silent "npm" "install -g @anthropic-ai/claude-code" | Out-Null
            # Refresh PATH
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        }

        if (-not (Test-CommandExists "claude")) {
            $errors += "Claude Code nao pode ser instalado"
        }
    }

    if (Test-CommandExists "claude") {
        Update-UI "Passo 2 de 4: Claude Code instalado" "" 50
    }

    # ── 3. yt-dlp ──
    Update-UI "Passo 3 de 4: Verificando yt-dlp..." "" 55

    if (-not (Test-CommandExists "yt-dlp")) {
        Update-UI "Passo 3 de 4: Instalando yt-dlp..." "" 60

        if (Test-CommandExists "winget") {
            Run-Silent "winget" "install yt-dlp --accept-package-agreements --accept-source-agreements --silent" | Out-Null
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        } elseif (Test-CommandExists "pip") {
            Run-Silent "pip" "install yt-dlp" | Out-Null
        } elseif (Test-CommandExists "pip3") {
            Run-Silent "pip3" "install yt-dlp" | Out-Null
        }

        if (-not (Test-CommandExists "yt-dlp")) {
            $errors += "yt-dlp nao pode ser instalado"
        }
    }

    if (Test-CommandExists "yt-dlp") {
        Update-UI "Passo 3 de 4: yt-dlp instalado" "" 75
    }

    # ── 4. Instalar plugin Sofia ──
    Update-UI "Passo 4 de 4: Instalando plugin Sofia..." "" 80

    if (Test-CommandExists "claude") {
        Update-UI "Passo 4 de 4: Instalando plugin via marketplace..." "" 85
        $exitCode = Run-Silent "claude" "plugin install $PLUGIN_NAME"
        if ($exitCode -ne 0) {
            $exitCode = Run-Silent "claude" "plugin install --url https://github.com/srbentostk/smart-content-plugin"
            if ($exitCode -ne 0) {
                $errors += "Plugin Sofia nao pode ser instalado"
            }
        }
    } else {
        $errors += "Claude Code nao esta disponivel para instalar o plugin"
    }

    # ── Resultado ──

    if ($errors.Count -eq 0) {
        Update-UI "Instalacao completa!" "Tudo pronto para usar a Sofia." 100

        $lblDesc.Text = "Para usar a Sofia:`n`n  1. Abra o PowerShell`n  2. Digite: claude`n  3. Na primeira vez, faca login em claude.ai`n  4. Depois digite:`n     /sofia:setup"
        $lblDesc.Refresh()

        $btnInstall.Text = "Abrir Claude"
        $btnInstall.Enabled = $true
        $btnCancel.Text = "Fechar"
        $btnCancel.Enabled = $true

        # Remover evento anterior e adicionar novo
        $btnInstall.add_Click({
            Start-Process powershell -ArgumentList "-NoExit", "-Command", "claude"
            $form.Close()
        }.GetNewClosure())

    } else {
        $errorMsg = $errors -join "`n  - "
        Update-UI "Instalacao parcial" "Alguns itens falharam." 100

        $lblDesc.Text = "Itens com problema:`n  - $errorMsg`n`nFeche e tente novamente, ou peca ajuda ao instrutor."
        $lblDesc.Refresh()

        $btnInstall.Text = "Tentar de novo"
        $btnInstall.Enabled = $true
        $btnCancel.Text = "Fechar"
        $btnCancel.Enabled = $true
    }
})

# ─────────────────────────────────────
# Mostrar janela
# ─────────────────────────────────────

[void]$form.ShowDialog()
