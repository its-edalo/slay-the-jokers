@echo off
if not exist "%APPDATA%\Balatro\Mods\SlayTheJokers\uvx.exe" (
    set UV_UNMANAGED_INSTALL=%APPDATA%\Balatro\Mods\SlayTheJokers
    powershell -ExecutionPolicy ByPass -Command "iex(New-Object Net.WebClient).DownloadString('https://astral.sh/uv/install.ps1')"
)
powershell -ExecutionPolicy ByPass -c "%APPDATA%\Balatro\Mods\SlayTheJokers\uvx.exe --with psutil --with google-cloud-storage python@3.12 -c 'import psutil, google.cloud'"
echo UV has been installed!
