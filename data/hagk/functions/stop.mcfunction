# Stop Hide and Go Kill game and restore world state
# Run to end the game: /function hagk:stop

# Display ending message
title @a times 40 100 40
title @a subtitle {"text":"Please note world rules have been restored!"}
title @a title {"text":"Hide and Go Kill Ending","color":"dark_green"}

# Restore gamerules
gamerule doDaylightCycle true
gamerule doWeatherCycle true
gamerule doMobSpawning true
gamerule doPatrolSpawning true
gamerule doTraderSpawning true
gamerule naturalRegeneration true
gamerule doInsomnia true
gamerule keepInventory false
gamerule mobGriefing true

# Cancel scheduled functions
schedule clear hagk:buff_loop
schedule clear hagk:weapon_loop

# Clear game items from all players
clear @a minecraft:trident[custom_data~{hunter:1b}]
clear @a minecraft:ender_pearl

# Clear any lingering effects
effect clear @a minecraft:saturation
effect clear @a minecraft:strength
effect clear @a minecraft:regeneration

# Reset player gamemodes to survival
gamemode survival @a[gamemode=adventure]

# Empty teams
team empty HUNTER
team empty HUNTED

# Reset all scoreboard values
scoreboard players reset @a hunter_buffer
scoreboard players reset @a hunted_buffer
scoreboard players reset @a hunted_death
scoreboard players reset @a hunted_leave
