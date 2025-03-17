@echo off
if not exist "%APPDATA%\Balatro\Mods\SlayTheJokers\uvx.exe" (
    set UV_UNMANAGED_INSTALL=%APPDATA%\Balatro\Mods\SlayTheJokers
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
)
%APPDATA%\Balatro\Mods\SlayTheJokers\uvx.exe --with psutil --with google-cloud-storage python@3.12 -c "import psutil, google.cloud"
if %ERRORLEVEL%==0 echo All required Python libraries have been installed.