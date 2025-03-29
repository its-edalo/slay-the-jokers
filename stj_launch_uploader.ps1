$installPath = "$env:APPDATA\Balatro\Mods\SlayTheJokers"
$uvxPath = Join-Path $installPath "uvx.exe"

if (-Not (Test-Path $uvxPath)) {
    $env:UV_UNMANAGED_INSTALL = $installPath
    irm https://astral.sh/uv/install.ps1 | iex
}

& $uvxPath --with psutil --with requests python@3.12 "$installPath\stj_uploader.py"
