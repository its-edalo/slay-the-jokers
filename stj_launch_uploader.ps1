$modPath = "$env:APPDATA\Balatro\Mods\SlayTheJokers"
$uvxPath = Join-Path $modPath "uvx.exe"

if (-Not (Test-Path $uvxPath)) {
    $env:UV_UNMANAGED_INSTALL = $modPath
    irm https://astral.sh/uv/install.ps1 | iex
}

& $uvxPath --with certifi==2025.1.31 --with psutil --with requests python@3.12 "$modPath\stj_uploader.py"
