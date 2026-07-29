# "Slay the Jokers" Overlay Mod

⚡ **Just want to install the mod quickly and don't care about anything else?** Follow the [TL;DR installation guide](docs/TLDR-INSTALL.md) for a fast setup.  
- However, I do recommend to continue reading instead, unless you've installed mods before.

## Overview

A mod that allows your viewers to hover over cards on your stream to see their effects and current values.

Does not require `steamodded`.

<img alt="Slay the Jokers Preview Image 1" src="docs/preview1.png" />

*(Screenshotted from [edzyttv](https://www.twitch.tv/edzyttv)'s stream, used with permission)*

---

If you need help or have suggestions, feel free to contact me at `itsedalo@gmail.com`.

## Installation

The installation guide can be found [`here`](INSTALL.md). Be sure to **read the `Things to Know Before Installing` section below** before installing.

## Things to Know Before Installing

- **Upload Key**: To use this mod, you'll need an upload key to the Slay the Jokers server.
    - You can get one using the automated system at https://edalo.net/stj (you will need to verify your Twitch account to prove it's really you).

- **Windows and Steam only**: This mod supports only the **Steam** version of the game on **Windows**.
    - The Xbox Game Pass PC version is not supported as it is incompatible with the required `Lovely` injector.

- **Stream Overlays**: This mod currently only works correctly if the game is shown at a 16:9 resolution (like 1920x1080 / 4K / 8K) and **fills the entire visible area of the stream**. Overlays that crop or reposition the game may cause card positions to misalign.
    - If that's a dealbreaker, feel free to contact me - I might be able to make it work for your setup.

- **Other Mods & Compatibility**: This mod is compatible with most simple mods.
    - Mods that **modify existing** card effects are **not** compatible (the original card's effect will be shown instead).
    - Mods that heavily alter game mechanics, card types, or interactable areas might cause crashes.


- **Disclaimer**: Some features might not work perfectly. If you encounter any issues, please let me know!
    - *More formal disclaimer for meanies: this project is a hobby project, provided as-is, with no guarantees of stability, correctness, or suitability for any purpose. You're welcome to use it - but I take no responsibility if something goes wrong.*

## Acknowledgments

Big Thank Yous to all the following people:

- [@tusharsadhwani](https://github.com/tusharsadhwani) for the suggestion and implementation of the `uv` package manager usage
- [@espav](https://twitch.tv/espav) for being the extension's first tester and providing invaluable feedback
- [@edzy](https://twitch.tv/edzyttv) for helping debug the mod and lending his face to the extension's cover image
- [@Boop Dog](https://github.com/goBoopADog) for creating the mod's Balatro Mod Index page
