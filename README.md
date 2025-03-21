# "Slay the Jokers" Overlay Mod

A mod that allows your viewers to hover over cards on your stream to see their effects and current values.

<img alt="Slay the Jokers Preview Image 1" src="docs/preview1.png" />

*(Screenshotted from [edzyttv](https://www.twitch.tv/edzyttv)'s stream, used with permission)*

---

If you need help, have suggestions, or need a credential file, feel free to contact me at `itsedalo@gmail.com`.

## Things to Know Before Installing

- **Disclaimer**: This mod is currently in beta, so some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it - but I take no responsibility if something goes wrong.*

- **Access Permissions**: Currently, in order to use this mod, you need permissions to upload to the Slay the Jokers server. **Contact me before installing** in order to receive a credential file.

- **Windows Only**: This mod currently supports only Windows systems.

- **Other Mods & Compatibility**: This mod has not been tested alongside other Balatro mods. Mods that add new cards or modify card names and effects are currently not compatible. Reskins, QoL mods, and other non-card-related mods should work, but have not been tested (except for the [Handy](https://github.com/SleepyG11/HandyBalatro) mod, which was confirmed to work).

- **Privacy**: This mod needs to upload data to the Slay the Jokers server (for details, see the `How It Works` section below). This includes **only game-related data** (such as card positions) - no personal or private information is collected. You can verify this by checking out `stj_save.lua` and `stj_uploader.py`.

## Installation

The installation guide can be found [`here`](INSTALL.md). Be sure to **read the `Things to Know Before Installing` section above** before installing.

## How It Works

When this mod is active, every short interval (of around a second), the game tracks the positions and details of all cards on screen and saves them into a file. A Python script then uploads this file to the Slay the Jokers server.

On the Twitch side, the extension retrieves this information from the server, allowing it to determine where cards are located on the screen and which details they should display.
