# Start Hide and Go Kill game
# Run to begin: /function hagk:start

# Validate lifecycle and team composition.
execute if score #game hagk_state matches 1 run tellraw @s {"text":"Hide and Go Kill is already running.","color":"yellow"}
execute if score #game hagk_state matches 1 run return 0
execute unless entity @a[tag=hagk.participant,team=HUNTER] run tellraw @s {"text":"Cannot start: assign at least one hunter.","color":"red"}
execute unless entity @a[tag=hagk.participant,team=HUNTER] run return 0
execute unless entity @a[tag=hagk.participant,team=HUNTED] run tellraw @s {"text":"Cannot start: assign at least one hunted player.","color":"red"}
execute unless entity @a[tag=hagk.participant,team=HUNTED] run return 0

# Preserve world-global state before applying minigame rules.
execute store result score #daylight hagk_world run gamerule doDaylightCycle
execute store result score #weather_cycle hagk_world run gamerule doWeatherCycle
execute store result score #mob_spawning hagk_world run gamerule doMobSpawning
execute store result score #patrol_spawning hagk_world run gamerule doPatrolSpawning
execute store result score #trader_spawning hagk_world run gamerule doTraderSpawning
execute store result score #natural_regen hagk_world run gamerule naturalRegeneration
execute store result score #insomnia hagk_world run gamerule doInsomnia
execute store result score #keep_inventory hagk_world run gamerule keepInventory
execute store result score #mob_griefing hagk_world run gamerule mobGriefing
execute store success score #raining hagk_world if predicate {condition:"minecraft:weather_check",raining:true}
execute store success score #thundering hagk_world if predicate {condition:"minecraft:weather_check",thundering:true}
execute store result storage hagk:state time int 1 run time query daytime

scoreboard players set #game hagk_state 1

# Display starting message to participants only.
title @a[tag=hagk.participant] times 20 60 20
title @a[tag=hagk.participant] subtitle {"text":"Hunted players become hunters when killed.","color":"gray"}
title @a[tag=hagk.participant] title {"text":"Hide and Go Kill","color":"red"}

# Set gamerules for controlled PvP environment
gamerule doDaylightCycle false
gamerule doWeatherCycle false
gamerule doMobSpawning false
gamerule doPatrolSpawning false
gamerule doTraderSpawning false
gamerule naturalRegeneration false
gamerule doInsomnia false
gamerule keepInventory true
gamerule mobGriefing false
time set noon
weather clear

# Start scheduled loops.
schedule clear hagk:buff_loop
schedule clear hagk:supply_loop
schedule function hagk:buff_loop 1t replace
schedule function hagk:supply_loop 1t replace
