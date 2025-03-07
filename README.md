# Easy Guide to Install "Slay the Jokers" Stream Overlay Mod

This simple guide will help you set up the mod that shows card positions on your stream. Each step is explained along with its purpose, so you can understand exactly what is being done and why.

## Before We Start

- This mod is currently in beta, so some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it — but I take no responsibility if something goes wrong.*

- Currently, in order to use this mod, you need permissions to upload to the Slay the Jokers server. Contact me before installing in order to receive a credential file.

- The mod currently supports only Windows systems.

## Step 1: Back Up Your Save Folder

Before installing any mod, it's always smart to back up your game data.

- Go to `%appdata%` (you can type this into your Windows search bar and press Enter). You should see a directory called `Balatro` there.

- Make a copy of the entire Balatro directory in two different safe locations.

*Why?* This ensures you won’t lose your progress or game settings if something goes wrong.

## Step 2: Install Lovely Injector

- Download "Lovely" from https://www.github.com/ethangreen-dev/lovely-injector/releases/tag/v0.7.1 (click the link that looks like "lovely-x86_64-pc-windows-msvc.zip")

- Unzip it and move the contained .dll file into your Balatro game directory on Steam (not the same as the appdata directory! You can open it through Steam: Right click Balatro -> Manage -> Browse local files. You should see `Balatro.exe` there, along with several other files)

*Why?* "Lovely" is a widely used, trusted modding tool that safely injects mods into the game.

## Step 3: Check Lovely Injector Installation

- Open Balatro through Steam.

- Look for a small black command window (cmd) opening alongside the game.

*Why?* This black window indicates that "Lovely" is correctly installed and running.

## Step 4: Install Python

- Download Python from https://www.python.org/downloads/

- Run the installer and select "Add Python to PATH" during installation.

*Why?* Python is necessary to run the script that uploads your game data to the overlay server. Python is a programming language commonly used for scripting and automation tasks, such as uploading data to servers. 

## Step 5: Set Up Python Dependencies

Next, open your Windows Command Prompt (type cmd in search) and run these commands:

`pip install psutil`

`pip install google-cloud-storage`

*Why?* These libraries allow Python to communicate with Google Cloud to upload your game data.

## Step 6: Install the "Slay the Jokers" Mod

- Download this mod (Code -> Download Zip)

- Unzip the downloaded file.

- Move the unzipped folder into the Mods folder located at `%appdata%\Balatro\Mods` .

*Why?* This is the folder that Lovely injects mods from.

## Step 7: Add Your Credential File

- Launch Balatro again. The black window will show a message similar to "no credentials."

- Close the game.

- Place the `stj-credentials.json` file (which I'll send you via Discord or similar) into the mod's directory: `%appdata%\Balatro\Mods\<name of folder you created>`

*Why?* The credential file verifies your account to connect to the Slay the Jokers server.

## Step 8: Verify Everything Works!

- Restart Balatro.

- The black command window should now periodically print messages saying it is uploading data.

Done!

You should now see the cards' positions on your stream overlay when you enable the extension. Enjoy streaming!
