# Slay the Jokers Mod - Installation Guide

This guide will help you set up the Slay the Jokers Mod. Each step is explained along with its purpose, so you can understand exactly what is being done and why.

⚡ **Just want to install the mod quickly and don't care about anything else?** Follow the [TL;DR installation guide](docs/TLDR-INSTALL.md) for a fast setup.

If you need help or have suggestions, contact me at `itsedalo@gmail.com`.

*If you got here through the Balatro Mod Manager, you can skip to Step 5.*

## Pre-Step: Acquire Your Upload Key

Before starting, you'll need an `upload.key` file for the Slay the Jokers server.
- You can get one using the automated system at https://edalo.net/stj (you will need to verify your Twitch account to prove it's really you).
    - After clicking `Authorize`, **wait** until the file downloads (don't click `click here if your browser does not redirect you.`)
- If something goes wrong or you prefer not to authorize, you can request a key at `itsedalo@gmail.com`.
    - Absolutely no need for anything formal or polite, you can just say `Hi, I'm <twitch name>, give me a key`

*Why?* Each streamer gets a unique key so their stream data stays separate. This prevents issues where one person's mod could interfere with another streamer's overlay.

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

- Move the unzipped folder into the Mods folder located at `%appdata%\Balatro\Mods`

*Why?* `%appdata%\Balatro\Mods` is the folder that Lovely injects mods from.

## Step 5: Add Your Upload Key

- Place the `upload.key` file you received in the pre-step into the `Balatro` data directory (`%appdata%\Balatro`)

*Why?* This key tells the mod who you are, so it can safely upload data to the server folder linked to your Twitch stream.

## Step 6: Perform First-time Setup

- Launch Balatro and wait for the game to fully load.

- The black command window will automatically download and install the required tools:
    - [`uv`](https://docs.astral.sh/uv/), a lightweight Python package manager.
    - Python libraries used by the mod.

- The `uv` installation will only happen the first time you launch the game.

*Why?* This mod uses [`Python`](https://www.python.org/), a popular programming language, to upload game data to the Slay the Jokers server. `uv` makes it simple to install and run Python packages without needing a global Python installation.

**Note:** The Python uploader is launched via a PowerShell script. It may change the size or font of the `Lovely` window.  

**Debugging Errors**: If you get an error similar to:  
- `Failed to get upload key` - make sure that you placed the `upload.key` file in the `Balatro` data directory (`%appdata%\Balatro`).
- `Failed to upload file` / `Invalid key` - the `upload.key` seems to be corrupted. Make sure that it's the right file, or request a new one.

## Step 7: Verify Everything Works!

- After setup completes, the black command window should periodically print messages indicating that data is being uploaded.

**Done!**

You should now see the cards' positions on your stream overlay when you enable the extension on your Twitch channel ([here](https://dashboard.twitch.tv/extensions/iaofk5k6d87u31z9uy2joje2fwn347)), after you refresh the browser tab. Enjoy streaming!

**Note**: When you start up the game you may occasionally see messages about `uvx` installing packages again, which can cause a slight delay (a few seconds) before the extension starts uploading. This is unintended and will be fixed in a future update - `uvx` seems to be clearing its cache more than expected.

---

If you ever want to remove the mod, just remove the Lovely DLL (`version.dll`) from the Balatro installation folder and delete the mod folder from `%appdata%\Balatro\Mods`. This will fully uninstall the mod.
