# Slay the Jokers - Known Issues and Missing Features

## Effects and Formatting

- Level text on Planet cards lacks color
- Floating and waving text effects do not work

## UI Elements

- Tags and Boss Blinds are not hoverable
- Sub-popups (describing keywords) are not implemented

## Mods

- Modded card descriptions are not formatted or colored
- Some Cryptid cards are not shown correctly (or at all)

## Codebase

- `uvx` is still using the `google-cloud-storage` package which is no longer needed (replace `--with google-cloud-storage` with `--with requests`)
- `uvx` re-installs libraries after the game has not been opened for a while
