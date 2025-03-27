# Slay the Jokers Mod - Installation Guide

This guide will help you set up the Slay the Jokers Mod. Each step is explained along with its purpose, so you can understand exactly what is being done and why.

⚡ **Just want to install the mod quickly and don't care about anything else?** Follow the [TL;DR installation guide](docs/TLDR-INSTALL.md) for a fast setup.

If you need help or have suggestions, contact me at `itsedalo@gmail.com`.

## Pre-Step: Request Your Upload Key

Before starting, contact me at `itsedalo@gmail.com` to receive an upload key file.

## Step 1: Back Up Your Save Folder

Before installing any mod, it's always smart to back up your game data.

- Go to `%appdata%` (you can type this into your Windows search bar and press Enter). You should see a directory called `Balatro` there.

- Make a copy of the entire Balatro directory in two different safe locations.

*Why?* This ensures you won’t lose your progress or game settings if something goes wrong.

## Step 2: Install Lovely Injector

- Open the Balatro installation folder (not the same as the appdata folder!). You can open it through Steam: Right click Balatro -> Manage -> Browse local files. You should see `Balatro.exe` there, along with several other files.

- Download "Lovely" from https://www.github.com/ethangreen-dev/lovely-injector/releases/tag/v0.7.1 (click the link that looks like "lovely-x86_64-pc-windows-msvc.zip")

- Unzip it and move the contained `version.dll` file into the Balatro installation folder.

*Why?* "Lovely" is a widely used, trusted modding tool that safely injects mods into the game.

**Note**: Lovely triggers some Antiviruses. Unfortunately, I have no control over that. You'll have to trust the Lovely developers, I guess.

## Step 3: Check Lovely Injector Installation

- Open Balatro through Steam.

- Look for a small black command window (cmd) opening alongside the game.

*Why?* This black window indicates that "Lovely" is correctly installed and running.

## Step 4: Install the "Slay the Jokers" Mod

- Download this mod - https://github.com/its-edalo/slay-the-jokers/archive/main.zip

- Unzip the downloaded file.

- Move the unzipped folder into the Mods folder located at `%appdata%\Balatro\Mods`, and rename it to `SlayTheJokers`

*Why?* This is the folder that Lovely injects mods from.

**Note**: If Chrome blocks your download, it's because of the `install_uv.bat` file in the next step. Try switching to [this](https://github.com/its-edalo/slay-the-jokers/blob/feature/no-bat-file/INSTALL.md) version of the mod without this file, that instructs how to install `uv` manually.

## Step 5: Install `uv` (Python Package Manager)

- Open the `SlayTheJokers` folder and double-click `install_uv.bat`. This will install `uv`, which is required to run Python for uploading the game's data.
- A black command window will open, and you'll see colorful loading bars gradually filling up as `uv` installs.
- Once the installation is complete, the window will close automatically, and you should see `uv.exe` and `uvx.exe` appear in the SlayTheJokers folder.

*Why?* This mod uses [`Python`](https://www.python.org/), a popular programming language, to upload the game's data to the Slay the Jokers server. [`uv`](https://docs.astral.sh/uv/) is a lightweight tool that helps install and run Python effortlessly.

**Note**: If you're having trouble running `install_uv.bat` by double-clicking, you can run it manually in a command line window:
- With the `SlayTheJokers` folder open, click on the folder path bar at the top of the window, type `cmd`, and press Enter.
- In the command window that opens, run `install_uv.bat`

## Step 6: Add Your Upload Key

- Launch Balatro again. The black window (that opened alongside the game) will show a message similar to `Upload key file not found`.

- Close the game.

- Place the `upload.key` file you received in the pre-step into the mod's directory: `%appdata%\Balatro\Mods\SlayTheJokers`

*Why?* The upload key file provides the necessary authentication for the mod to upload data to the Slay the Jokers server.

## Step 7: Verify Everything Works!

- Restart Balatro.

- After the game fully loads, the black command window should now periodically print messages saying it is uploading data.


**Done!**

You should now see the cards' positions on your stream overlay when you enable the extension on your Twitch channel ([here](https://dashboard.twitch.tv/extensions/iaofk5k6d87u31z9uy2joje2fwn347)). Enjoy streaming!

**Note**: When you start up the game you may occasionally see messages about `uvx` installing packages, which can cause a slight delay (a few seconds) before the extension starts uploading. This is unintended and will be fixed in a future update - `uvx` seems to be clearing its cache more than expected.

---

If you ever want to remove the mod, just remove the Lovely DLL (`version.dll`) from the Balatro installation folder and delete the mod folder from `%appdata%\Balatro\Mods`. This will fully uninstall the mod.
