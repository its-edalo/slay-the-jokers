# Slay the Jokers Mod - TL;DR Installation Guide

Only follow this guide if you just want to get the mod installed with as little hassle and sidetracking as possible.
If you need detailed instructions, explanations, or steps to back up your save, refer to the [full installation guide](../INSTALL.md).

## Instructions

1. Contact me at `itsedalo@gmail.com` to receive `upload.key`
2. Download [Lovely](https://www.github.com/ethangreen-dev/lovely-injector/releases/tag/v0.7.1) 
3. Unzip it and move the `version.dll` file into the Balatro installation folder (where `Balatro.exe` is)
4. Download [this mod](https://github.com/its-edalo/slay-the-jokers/archive/main.zip)
5. Unzip it, move the unzipped folder into `%appdata%\Balatro\Mods`, and rename it to `SlayTheJokers`
6. Open a command line window (press Windows + R, type cmd, and press Enter), copy and paste the next line and press Enter:
`set UV_UNMANAGED_INSTALL=%APPDATA%\Balatro\Mods\SlayTheJokers && powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"`
7. Place `upload.key` in the `SlayTheJokers` directory
8. Open Balatro, wait until it fully loads, and verify that a black command window opens alongside it and prints data upload messages
9. Enable the [extension](https://dashboard.twitch.tv/extensions/iaofk5k6d87u31z9uy2joje2fwn347) on your Twitch channel

---

If anything is unclear or you run into issues, try referring to the [full installation guide](../INSTALL.md). 
