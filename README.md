# "Slay the Jokers" Overlay Mod

<img width="861" alt="Screenshot 2025-03-15 at 3 53 34 AM" src="https://github.com/user-attachments/assets/09da2631-24d5-4240-ad29-7e22306c5f5e" />

<img width="862" alt="Screenshot 2025-03-15 at 3 53 12 AM" src="https://github.com/user-attachments/assets/b6142e1a-0d6e-4171-8a31-e7e173329e75" />

# Installation Guide

This simple guide will help you set up the mod that shows card positions on your stream. Each step is explained along with its purpose, so you can understand exactly what is being done and why.

If you need help, have suggestions, or need a credential file, contact me on `itsedalo@gmail.com`.

## Before We Start

- This mod is currently in beta, so some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it - but I take no responsibility if something goes wrong.*

- Currently, in order to use this mod, you need permissions to upload to the Slay the Jokers server. **Contact me before installing** in order to receive a credential file.

- The mod currently supports only Windows systems.

- This mod has not been tested alongside other Balatro mods. For now, using it together with other mods is not recommended.

- The mod **only uploads game-related data** (such as card positions) to the Slay the Jokers server - no personal or private information is collected. You can verify this by checking out `stj_save.lua` and `stj_uploader.py`.

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

Note: Lovely triggers some Antiviruses. Unfortunately, I have no control over that. You'll have to trust the Lovely developers, I guess.

## Step 3: Check Lovely Injector Installation

- Open Balatro through Steam.

- Look for a small black command window (cmd) opening alongside the game.

*Why?* This black window indicates that "Lovely" is correctly installed and running.

## Step 4: Install the "Slay the Jokers" Mod

- Download this mod (Code -> Download Zip)

- Unzip the downloaded file.

- Move the unzipped folder into the Mods folder located at `%appdata%\Balatro\Mods`, and rename it to `SlayTheJokers`

*Why?* This is the folder that Lovely injects mods from.

## Step 5: Install `uv` (Python Package Manager)

- Open the `SlayTheJokers` folder and double-click `install_uv.bat`. This will install `uv`, which is required to run Python for uploading the game's data.
- A black command window will open, and you'll see colorful loading bars gradually filling up as `uv` installs.
- Once the installation is complete, the window will close automatically, and you should see `uv.exe` and `uvx.exe` appear in the SlayTheJokers folder.

*Why?* [`uv`](https://docs.astral.sh/uv/) is a lightweight Python package manager that allows the mod to run scripts for uploading the game's data. Python is a programming language commonly used for tasks like automation and sending data to servers.

## Step 6: Add Your Credential File

- Launch Balatro again. The black window (that opened alongside the game) will show a message similar to `Credential file not found`.

- Close the game.

- Place the `stj-credentials.json` file (which I'll send you via Discord or similar) into the mod's directory: `%appdata%\Balatro\Mods\SlayTheJokers`

*Why?* The credential file provides the necessary authentication for the mod to upload data to the Slay the Jokers server.

## Step 7: Verify Everything Works!

- Restart Balatro.

- After the game fully loads, the black command window should now periodically print messages saying it is uploading data.

Done!

You should now see the cards' positions on your stream overlay when you enable the extension. Enjoy streaming!

---

If you ever want to remove the mod, just remove the Lovely DLL (`version.dll`) from the Balatro installation folder and delete the mod folder from `%appdata%\Balatro\Mods`. This will fully uninstall the mod.
