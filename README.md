# Hide and Go Kill

A Minecraft Java Edition PvP minigame datapack. Hunters pursue the hunted; every hunted player killed returns as another hunter.

## Features

- **Two Teams**: Hunters and hunted receive different equipment and effects
- **Conversion**: A hunted player becomes a hunter after dying
- **Win Detection**: The game ends when either team has no players left
- **Hidden Nametags**: Team nametags are hidden and friendly fire is disabled
- **Team Buffs**:
  - Hunters: Saturation, strength, regeneration, a custom trident, and replenishing ender pearls
  - Hunted: Saturation and one ender pearl
- **State Restoration**: Player gamemodes, world time, weather, and modified gamerules are restored when the game ends
- **Reload Recovery**: An active game resumes its scheduled loops after `/reload`

## Installation

1. Download or clone this repository
2. Copy the `HideAndGoKill` folder to your world's `datapacks` folder
3. Run `/reload` in-game or restart the world

Initialization happens automatically when the datapack loads.

## Usage

### Assign Players

```mcfunction
# Assign the nearest player as hunted
/scoreboard players set @p hunted_buffer 1

# Assign the nearest player as a hunter
/scoreboard players set @p hunter_buffer 1
```

Assignment records the player's current gamemode, places them in adventure mode, and gives them their role equipment. Reassigning a participant switches their role without losing the originally recorded gamemode.

At least one hunter and one hunted player must be assigned before the game can start.

### Start

```mcfunction
/function hagk:start
```

Starting records the current world state, applies the minigame gamerules, fixes the time at noon, clears the weather, and starts the effect and supply loops.

### Stop

```mcfunction
/function hagk:stop
```

Stopping cancels scheduled functions, removes only datapack-issued items, restores participant gamemodes, and restores the world state captured at start.

### Leave

```mcfunction
/scoreboard players set @p hunted_leave 1
```

Despite the legacy objective name, `hunted_leave` works for either role.

## Game Flow

1. Assign all players to `HUNTER` or `HUNTED`.
2. Run `/function hagk:start`.
3. A hunted player who dies is converted to a hunter.
4. Hunters win when no hunted players remain.
5. Hunted players win if no hunters remain.
6. The world and participant state are restored automatically after a win.

## Compatibility

- Minecraft Java Edition data pack formats 48 through 100
- Smoke-tested locally with Minecraft 1.21.8 and 1.21.10

Minecraft 1.21 renamed datapack directories to their singular forms. This repository intentionally uses `data/hagk/function` and `data/minecraft/tags/function`.

## Operational Notes

- Game-issued items carry custom data so cleanup does not remove ordinary tridents or ender pearls.
- Only tagged participants receive titles, effects, equipment, or gamemode changes.
- Team membership itself cannot be restored dynamically. Assigning a player replaces membership in any pre-existing scoreboard team.
- Existing saturation, strength, or regeneration effects are replaced by game effects and cleared when that participant leaves.
- An offline participant is restored automatically after reconnecting to a stopped game.

## Development

Run static validation:

```bash
./tests/validate.py
```

Smoke-load the datapack using locally installed Minecraft versions:

```bash
./tests/smoke-gametest.sh 1.21.8
./tests/smoke-gametest.sh 1.21.10
```

The smoke test uses the Minecraft launcher's local version files and Java runtime; it does not download dependencies.

## License

MIT
