# Scheduled buff application loop
# Runs every 40 ticks (2 seconds) instead of every tick for performance

execute unless score #game hagk_state matches 1 run return 0
function hagk:buffs
schedule function hagk:buff_loop 40t replace
