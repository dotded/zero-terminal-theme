param(
    [Parameter(Mandatory = $true)]
    [string]$SelectionFile
)

if (-not (Test-Path -LiteralPath $SelectionFile -PathType Leaf)) { return }

$path = (Get-Content -LiteralPath $SelectionFile -Raw -Encoding UTF8 -ErrorAction SilentlyContinue)
if ([string]::IsNullOrWhiteSpace($path)) { return }
$path = $path.Trim()
if (-not (Test-Path -LiteralPath $path -PathType Container)) { return }

$esc = [char]27
$gold = "$esc[38;2;203;193;144m"
$moss = "$esc[38;2;133;140;88m"
$rust = "$esc[38;2;196;98;69m"
$reset = "$esc[0m"

Write-Output ''
Write-Output "${gold}  DIRECTORY CONTENTS${reset}"
Write-Output "${moss}  $path${reset}"
Write-Output ''

if (Get-Command eza -ErrorAction SilentlyContinue) {
    & eza --icons=always --group-directories-first --color=always --all --level=2 --tree -- "$path"
} else {
    Write-Output "${rust}  Eza is not installed or is not on PATH.${reset}"
}

Write-Output ''
Write-Output "${rust}  ENTER SELECT  |  ESC CANCEL${reset}"
