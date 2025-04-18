# "Slay the Jokers" Overlay Mod

⚡ **Just want to install the mod quickly and don't care about anything else?** Follow the [TL;DR installation guide](docs/TLDR-INSTALL.md) for a fast setup.  
- However, I do recommend to continue reading instead, unless you've installed mods before.

## Overview

A mod that allows your viewers to hover over cards on your stream to see their effects and current values.

<img alt="Slay the Jokers Preview Image 1" src="docs/preview1.png" />

*(Screenshotted from [edzyttv](https://www.twitch.tv/edzyttv)'s stream, used with permission)*

---

If you need help, have suggestions, or need an upload key, feel free to contact me at `itsedalo@gmail.com`.

## Things to Know Before Installing

- **Disclaimer**: This mod is still under development, so some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it - but I take no responsibility if something goes wrong.*

- **Access Permissions**: Currently, in order to use this mod, you need permissions to upload to the Slay the Jokers server. **Contact me before installing** at `itsedalo@gmail.com` in order to receive an upload key.
    - Absolutely no need for anything formal or polite, you can just say `Hi, I'm <twitch name>, give me a key.`, word for word if you want. I'll try to send you the key quickly.

- **Windows Only**: This mod currently supports only Windows systems.

- **Stream Overlays**: This mod currently only works correctly if the game is shown at a 16:9 resolution (like 1920x1080 / 4K / 8K) and fills the entire visible area of the stream. Overlays that crop or reposition the game may cause card positions to misalign.
    - If that's a dealbreaker, feel free to contact me - I might be able to make it work for your setup.

- **Other Mods & Compatibility**: This mod has only been partially tested alongside other Balatro mods.
    - Compatible mods:
        - Reskins, QoL mods, and other non-card-related mods should work in their entirety, but have not been tested (except for the [Handy](https://github.com/SleepyG11/HandyBalatro) mod, which was confirmed to work).
        -  Mods that add new cards should generally work, aside from some potential minor formatting quirks. Among mods that were confirmed to work are:
            - [Extra Credit](https://github.com/GuilloryCraft/ExtraCredit)
            - [Paperback](https://github.com/Balatro-Paperback/paperback)
            - [Neato](https://github.com/neatoqueen/NeatoJokers)
            - [Cryptid](https://github.com/MathIsFun0/Cryptid)
            - The [Balatro Multiplayer](https://github.com/V-rtualized/BalatroMultiplayer) Mod
    - Incompatible mods:
        - Mods that modify existing card effects are **not** compatible (the original card's effect will be shown instead)

- **Privacy**: This mod needs to upload data to the Slay the Jokers server (for details, see the `How It Works` section below). This includes **only game-related data** (such as card positions) - no personal or private information is collected. You can verify this by checking out `src/stj_save.lua` and `stj_uploader.py`.

## Installation

The installation guide can be found [`here`](INSTALL.md). Be sure to **read the `Things to Know Before Installing` section above** before installing.

## How It Works

When this mod is active, every short interval (of around a second), the game tracks the positions and details of all cards on screen and saves them into a file. A Python script then uploads this file to the Slay the Jokers server.

On the Twitch side, the extension retrieves this information from the server, allowing it to determine where cards are located on the screen and which details they should display.
