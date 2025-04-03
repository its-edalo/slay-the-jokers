# "Slay the Jokers" Overlay Mod

⚡ **Just want to install the mod quickly and don't care about anything else?** Follow the [TL;DR installation guide](docs/TLDR-INSTALL.md) for a fast setup.  
- However, I do recommend to continue reading instead.

## Overview

A mod that allows your viewers to hover over cards on your stream to see their effects and current values.

<img alt="Slay the Jokers Preview Image 1" src="docs/preview1.png" />

*(Screenshotted from [edzyttv](https://www.twitch.tv/edzyttv)'s stream, used with permission)*

---

If you need help, have suggestions, or need an upload key, feel free to contact me at `itsedalo@gmail.com`.

## Things to Know Before Installing

- **Disclaimer**: This mod is still under development, so some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it - but I take no responsibility if something goes wrong.*

- **Access Permissions**: Currently, in order to use this mod, you need permissions to upload to the Slay the Jokers server. **Contact me before installing** in order to receive an upload key.

- **Windows Only**: This mod currently supports only Windows systems.

- **Other Mods & Compatibility**: This mod has only been partially tested alongside other Balatro mods.
    - Compatible mods:
        - Reskins, QoL mods, and other non-card-related mods should work in their entirety, but have not been tested (except for the [Handy](https://github.com/SleepyG11/HandyBalatro) mod, which was confirmed to work).
        -  Mods that add new cards should partially work - descriptions will appear, but they will not be properly formatted or colored. Among mods that were confirmed to work are:
            - [Extra Credit](https://github.com/GuilloryCraft/ExtraCredit)
            - [Paperback](https://github.com/Balatro-Paperback/paperback)
            - [Neato](https://github.com/neatoqueen/NeatoJokers)
            - [Cryptid](https://github.com/MathIsFun0/Cryptid)
    - Incompatible mods:
        - Mods that modify existing card effects are **not** compatible.
    - Needs more testing:
        - The multiplayer mod has **not** been thoroughly tested and some users have reported crashes on past versions (that were hopefully fixed by the latest updates).   

- **Privacy**: This mod needs to upload data to the Slay the Jokers server (for details, see the `How It Works` section below). This includes **only game-related data** (such as card positions) - no personal or private information is collected. You can verify this by checking out `stj_save.lua` and `stj_uploader.py`.

## Installation

The installation guide can be found [`here`](INSTALL.md). Be sure to **read the `Things to Know Before Installing` section above** before installing.

## How It Works

When this mod is active, every short interval (of around a second), the game tracks the positions and details of all cards on screen and saves them into a file. A Python script then uploads this file to the Slay the Jokers server.

On the Twitch side, the extension retrieves this information from the server, allowing it to determine where cards are located on the screen and which details they should display.
