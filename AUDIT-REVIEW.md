# HideAndGoKill Review

> **Historical review — superseded 2026-07-28.** This document describes the
> pre-cleanup implementation and is retained as provenance. The current pack
> uses Minecraft 1.21's singular datapack directories, current cross-version
> metadata, tagged game items, scheduled effect/supply loops, participant
> isolation, automatic win detection, and world/player state restoration.
> Run `./tests/validate.py` and `./tests/smoke-gametest.sh <version>` against
> the current tree rather than treating the findings below as current.

## Summary

A Minecraft datapack implementing a "Hide and Seek" style PvP minigame where hunters chase hunted players. The codebase is small (~3KB across 9 mcfunction files) and functional but shows signs of being a quick prototype with several logic bugs, inconsistencies, and missing features that would affect gameplay reliability.

## Critical Issues

- **buffs.mcfunction:2** Logic bug: Line gives HUNTER saturation when HUNTED exists, likely should give effect to HUNTED team instead. Copy-paste error duplicates line 1's target.

- **stop.mcfunction** Missing time restoration: `start.mcfunction` sets `time set noon` but `stop.mcfunction` does not restore the original time state.

- **pack.mcmeta:3** Outdated pack_format: Value `5` corresponds to Minecraft 1.15-1.16.1. Current Minecraft versions use higher values (e.g., 48 for 1.21.4). This may cause compatibility warnings or failures.

- **hunted.mcfunction:5** Race condition potential: The complex NBT check for ender_pearl inventory could fail intermittently during rapid tick execution, potentially giving duplicate pearls.

- **tick.json** Performance concern: Running 6 functions every tick (20 times/second) with multiple entity selectors and NBT checks is inefficient. Most operations do not need tick-rate execution.

## Recommendations

- **[High]** Fix `buffs.mcfunction` line 2 - change target from `@p[team=HUNTER]` to `@p[team=HUNTED]` to give hunted players saturation as well.

- **[High]** Add `hunted_death` scoreboard objective trigger. Currently `init.mcfunction` creates it as `dummy` but `death.mcfunction` expects it to be set externally. Need advancement or death detection trigger like:
  ```
  scoreboard objectives add hunted_death deathCount
  ```

- **[Medium]** Reduce tick frequency - move `buffs`, `weapons` to scheduled functions (every 20-60 ticks) rather than every tick. Only `death` and team-joining functions benefit from tick-rate checks.

- **[Medium]** Add missing cleanup in `stop.mcfunction`:
  - Clear teams (`team empty HUNTER`, `team empty HUNTED`)
  - Clear player inventories of game items (trident, pearls)
  - Reset player gamemodes to survival

- **[Low]** Update `pack_format` in `pack.mcmeta` to match target Minecraft version.

- **[Low]** Add comments to mcfunction files explaining purpose and expected game flow.

- **[Low]** README is incomplete - missing instructions for:
  - How to start the game (`/function hagk:start`)
  - How to stop the game (`/function hagk:stop`)
  - Minimum player requirements
  - Win conditions

## Scores (1-10)

- Code Quality: 5
- Architecture: 6
- Completeness: 4
- Standards: 5

## Notes

**Good Patterns:**
- Clean separation of concerns (each function has single responsibility)
- Proper use of scoreboard buffers for async team joining
- Custom NBT tag `{hunter:1b}` on trident prevents item duplication exploits
- Gamerule management in start/stop creates controlled environment

**Concerns:**
- No win condition logic - game runs indefinitely
- No player count validation before start
- Hunted players only get 1 ender pearl ever (no replenishment mechanism after use)
- Hunter trident has `impaling:10` and `channeling:10` which exceeds normal enchantment caps - may behave unexpectedly depending on Minecraft version
- No spectator mode for eliminated players
- `@p` selector targets nearest player, not all players - may cause issues in multiplayer (should use `@a` in many places)

**Questions:**
- Is the game designed for specific player counts?
- Should hunted players have any defensive capabilities beyond one ender pearl?
- What triggers `hunted_death` score increment? Currently nothing in the pack sets this.
