# Hide and Go Kill

A PvP minigame datapack for Minecraft where hunters pursue the hunted in an intense survival game.

## Features

- **Two Teams**: HUNTER and HUNTED with different abilities
- **Hidden Nametags**: Players can't see enemy nametags
- **Team Buffs**:
  - Hunters: Saturation, Strength, Regeneration
  - Hunted: Saturation only
- **Controlled Environment**: No mob spawning, weather, or day/night cycle

## Installation

1. Download or clone this repository
2. Copy the `HideAndGoKill` folder to your world's `datapacks` folder
3. Run `/reload` in-game or restart the world

## Usage

### Setup (Run Once)

```
/function hagk:init
```

This creates the teams and scoreboards needed for the game.

### Joining Teams

Players join teams by setting their buffer score:

```
# Join as hunted (prey)
/scoreboard players set @p hunted_buffer 1

# Join as hunter (predator)
/scoreboard players set @p hunter_buffer 1
```

### Starting the Game

```
/function hagk:start
```

### Stopping the Game

```
/function hagk:stop
```

### Leaving the Game

```
/scoreboard players set @p hunted_leave 1
```

## Requirements

- Minecraft 1.21+
- Data Pack format 48+

## License

MIT
