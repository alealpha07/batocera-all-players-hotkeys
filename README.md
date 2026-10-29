# batocera-all-players-hotkeys

A [Batocera](https://batocera.org/) service that gives every player the hotkeys that normally only work on player 1.

Built for multi-player setups like arcade cabinets, where any player should be able to quit the game or open the menu without reaching for the P1 controls. Without this service, only the player 1 controller reacts to Hotkey + Start and the other hotkeys.

With the service enabled:

| Hotkey                   | Action                  | Without service | With service |
| ------------------------ | ----------------------- | --------------- | ------------ |
| Hotkey + Start           | Exit the game           | P1              | P1 … P8      |
| Hotkey + B               | Menu                    | P1              | P1 … P8      |
| Hotkey + A               | Batocera control center | P1              | P1 … P8      |
| Hotkey + Y / X           | Save / load state       | P1              | P1 … P8      |
| Hotkey + up / down       | Previous / next slot    | P1              | P1 … P8      |
| Hotkey + left / right    | Rewind / fast forward   | P1              | P1 … P8      |
| Other hotkeys            | Screenshot, disk swap…  | P1              | P1 … P8      |

Every hotkey defined for player 1 is copied to players 2 to 8, so custom hotkeys follow too.

## Why it is needed

In-game hotkeys are handled by evmapy, which configgen starts for every game. It reads `hotkeys.keys` and only configures a controller if the file has an `actions_player<N>` section for that player number. The stock file only has `actions_player1`, so only player 1 gets hotkeys.

## How it works

When the service starts, it generates a copy of the `hotkeys.keys` file that evmapy uses, with `actions_player2` … `actions_player8` copied from `actions_player1`, and bind-mounts it over the original.

- The source is `/userdata/system/configs/hotkeys.keys` if it exists, otherwise `/usr/share/evmapy/hotkeys.keys`, the same rule configgen follows.
- Player sections that already exist are kept as they are, so custom per-player hotkeys are respected.
- The file is regenerated on every start, so it follows Batocera updates.
- Nothing runs in the background. Stopping the service removes the bind mount, and the original file is never modified on disk.

## Requirements

- Batocera with user services support (`batocera-services`). Tested on Batocera 43.

## Install

Copy the repository to the Batocera machine and run the installer:

```sh
bash install.sh
```

The installer copies:

- `services/all_players_hotkeys` to `/userdata/system/services/`
- `bin/all-players-hotkeys-generate` to `/userdata/system/all-players-hotkeys/`

It then enables and starts the service. It is safe to run it again to update.

## Enable / disable

From EmulationStation: **Main menu → System settings → Services → `all_players_hotkeys`**.

## Uninstall

```sh
bash uninstall.sh
```

This stops and disables the service and removes its files and log.

## Limitations

- On arcade sticks the hotkey is usually the Select / Coin button: holding Coin and pressing Start exits the game for any player.
- While the service is running, `hotkeys.keys` shows the generated copy. To edit your own hotkeys, stop the service, edit the file, then start it again.
- Systems that ship their own per-player key files (for example Demul, Model 2, MUGEN, Ikemen) keep their own bindings where they overlap with a hotkey.

## License

[MIT](LICENSE)
