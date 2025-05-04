$modPath = Get-ChildItem "$env:APPDATA\Balatro\Mods" -Directory | Where-Object { $_.Name -match "^Slay[-]?The[-]?Jokers" } | Select-Object -First 1 | ForEach-Object { $_.FullName }
$uvxPath = Join-Path $modPath "uvx.exe"

if (-Not (Test-Path $uvxPath)) {
    $env:UV_UNMANAGED_INSTALL = $modPath
    irm https://astral.sh/uv/install.ps1 | iex
}

& $uvxPath --with certifi==2025.1.31 --with psutil --with requests python@3.12 "$modPath\stj_uploader.py"
