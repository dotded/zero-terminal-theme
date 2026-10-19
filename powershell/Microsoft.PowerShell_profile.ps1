# PowerShell profile
# Windows PowerShell 5.1 / PowerShell 7

# Prompt and startup
$themePath = Join-Path $HOME '.config\ohmyposh\zero-adaptive.omp.json'
if ((Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and (Test-Path -LiteralPath $themePath)) {
    oh-my-posh init pwsh --config $themePath | Invoke-Expression
}
if ($env:WT_NO_FASTFETCH -ne '1' -and (Get-Command fastfetch -ErrorAction SilentlyContinue)) {
    fastfetch
}

# Optional applications
function global:btop {
    $command = Get-Command btop4win.exe -ErrorAction SilentlyContinue
    if ($command) { & $command.Source @args }
    else { Write-Warning 'btop4win.exe is not available on PATH.' }
}
function global:cmatrix {
    $exe = Join-Path $HOME 'Tools\cmatrix\cmatrix.exe'
    if (Test-Path -LiteralPath $exe) { & $exe -a -c -C green -u 5 @args }
    else { Write-Warning "Missing cmatrix executable: $exe" }
}
function global:y {
    if (-not (Get-Command yazi.exe -ErrorAction SilentlyContinue)) {
        Write-Warning 'Yazi is not installed or is not on PATH.'
        return
    }
    $tmp = New-TemporaryFile
    try {
        yazi.exe @args --cwd-file="$($tmp.FullName)"
        $cwd = Get-Content -LiteralPath $tmp.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if ($cwd) {
            $cwd = $cwd.Trim()
            if ((Test-Path -LiteralPath $cwd -PathType Container) -and ($cwd -ne $PWD.Path)) {
                Set-Location -LiteralPath $cwd
            }
        }
    }
    finally { Remove-Item -LiteralPath $tmp.FullName -Force -ErrorAction SilentlyContinue }
}
function global:pipes {
    $bash = 'C:\Program Files\Git\bin\bash.exe'
    $script = Join-Path $HOME 'Tools\pipes.sh\pipes.sh'
    if (-not ((Test-Path -LiteralPath $bash) -and (Test-Path -LiteralPath $script))) {
        Write-Warning 'Git Bash or pipes.sh was not found.'
        return
    }
    $oldLang = $env:LANG
    $oldLcAll = $env:LC_ALL
    try {
        $env:LANG = 'en_US.UTF-8'
        $env:LC_ALL = 'en_US.UTF-8'
        & $bash $script -p 5 -t 3 @args
    }
    finally {
        $env:LANG = $oldLang
        $env:LC_ALL = $oldLcAll
    }
}
function global:cava {
    $exe = Join-Path $HOME 'Tools\Cava\cava.exe'
    $config = Join-Path $env:APPDATA 'cava\config'
    if (Test-Path -LiteralPath $exe) { & $exe -p $config @args }
    else { Write-Warning "Missing CAVA executable: $exe" }
}

# File navigation and colours
$env:EZA_COLORS = 'di=38;2;133;140;88:fi=38;2;220;210;164:ln=38;2;169;172;107:ex=38;2;196;98;69'
Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
Remove-Item Alias:ll -Force -ErrorAction SilentlyContinue
Remove-Item Alias:la -Force -ErrorAction SilentlyContinue
function global:ls   { if (Get-Command eza -ErrorAction SilentlyContinue) { & eza --icons=always --group-directories-first @args } else { Get-ChildItem @args } }
function global:ll   { if (Get-Command eza -ErrorAction SilentlyContinue) { & eza -lah --icons=always --group-directories-first --git @args } else { Get-ChildItem -Force @args } }
function global:la   { if (Get-Command eza -ErrorAction SilentlyContinue) { & eza -a --icons=always --group-directories-first @args } else { Get-ChildItem -Force @args } }
function global:tree { if (Get-Command eza -ErrorAction SilentlyContinue) { & eza --tree --icons=always --group-directories-first --level=2 @args } else { Write-Warning 'eza is not installed.' } }

# Zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# FZF styling
$env:FZF_DEFAULT_OPTS = @(
    '--height=55%'
    '--layout=reverse'
    '--border=rounded'
    '--margin=1,2'
    '--padding=1,2'
    '--info=inline'
    '--prompt=TRAVEL > '
    '--pointer=>'
    '--marker=+'
    '--color=fg:#DCD2A4,bg:#171814'
    '--color=hl:#C46245,fg+:#CBC190,bg+:#343A28,hl+:#C46245'
    '--color=info:#A9AC6B,prompt:#CBC190,pointer:#C46245'
    '--color=marker:#858C58,spinner:#858C58,header:#858C58'
    '--color=border:#545635,separator:#545635'
) -join ' '

# Zoxide + FZF directory selector
function global:zz {
    if (-not (Get-Command zoxide -ErrorAction SilentlyContinue)) {
        Write-Warning 'zoxide is not installed or is not on PATH.'
        return
    }
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
        Write-Warning 'fzf is not installed or is not on PATH.'
        return
    }
    $previewScript = Join-Path $HOME 'Tools\FZF\preview.ps1'
    if (-not (Test-Path -LiteralPath $previewScript -PathType Leaf)) {
        Write-Warning "Missing preview helper: $previewScript"
        return
    }
    $directories = @(zoxide query --list | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Container) })
    if ($directories.Count -eq 0) {
        Write-Warning 'No learned directories yet. Visit folders with cd first.'
        return
    }
    $selectionFile = [System.IO.Path]::GetTempFileName()
    try {
        $previewCommand = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "' + $previewScript + '" {f}'
        $options = @(
            '--height=65%'
            '--layout=reverse'
            '--border=rounded'
            '--margin=1,2'
            '--padding=1,2'
            '--prompt=TRAVEL > '
            '--pointer=>'
            '--info=inline'
            '--preview-window=right:55%:wrap:border-left'
            '--color=fg:#DCD2A4,bg:#171814'
            '--color=hl:#C46245,fg+:#CBC190,bg+:#343A28,hl+:#C46245'
            '--color=info:#A9AC6B,prompt:#CBC190,pointer:#C46245'
            '--color=border:#545635,separator:#545635'
            ('--preview=' + $previewCommand)
        )
        $directories | & fzf @options | Set-Content -LiteralPath $selectionFile -Encoding UTF8
        if ($LASTEXITCODE -ne 0) { return }
        $selected = Get-Content -LiteralPath $selectionFile -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $selected) { return }
        $selected = $selected.Trim()
        if (Test-Path -LiteralPath $selected -PathType Container) {
            Set-Location -LiteralPath $selected
        }
    }
    finally { Remove-Item -LiteralPath $selectionFile -Force -ErrorAction SilentlyContinue }
}
Remove-Item Alias:zi -Force -ErrorAction SilentlyContinue
function global:zi { zz }
