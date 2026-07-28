execute if score #daylight hagk_world matches 1 run gamerule doDaylightCycle true
execute if score #daylight hagk_world matches 0 run gamerule doDaylightCycle false
execute if score #weather_cycle hagk_world matches 1 run gamerule doWeatherCycle true
execute if score #weather_cycle hagk_world matches 0 run gamerule doWeatherCycle false
execute if score #mob_spawning hagk_world matches 1 run gamerule doMobSpawning true
execute if score #mob_spawning hagk_world matches 0 run gamerule doMobSpawning false
execute if score #patrol_spawning hagk_world matches 1 run gamerule doPatrolSpawning true
execute if score #patrol_spawning hagk_world matches 0 run gamerule doPatrolSpawning false
execute if score #trader_spawning hagk_world matches 1 run gamerule doTraderSpawning true
execute if score #trader_spawning hagk_world matches 0 run gamerule doTraderSpawning false
execute if score #natural_regen hagk_world matches 1 run gamerule naturalRegeneration true
execute if score #natural_regen hagk_world matches 0 run gamerule naturalRegeneration false
execute if score #insomnia hagk_world matches 1 run gamerule doInsomnia true
execute if score #insomnia hagk_world matches 0 run gamerule doInsomnia false
execute if score #keep_inventory hagk_world matches 1 run gamerule keepInventory true
execute if score #keep_inventory hagk_world matches 0 run gamerule keepInventory false
execute if score #mob_griefing hagk_world matches 1 run gamerule mobGriefing true
execute if score #mob_griefing hagk_world matches 0 run gamerule mobGriefing false

execute if score #thundering hagk_world matches 1 run weather thunder
execute unless score #thundering hagk_world matches 1 if score #raining hagk_world matches 1 run weather rain
execute unless score #thundering hagk_world matches 1 unless score #raining hagk_world matches 1 run weather clear

function hagk:restore_time with storage hagk:state
