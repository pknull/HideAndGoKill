# Start Hide and Go Kill game
# Run to begin: /function hagk:start

# Display starting message
title @a times 40 100 40
title @a subtitle ["",{"text":"Please note "},{"text":"world ","obfuscated":true},{"text":"rules have been changed!"}]
title @a title {"text":"Hide and Go Kill Starting","color":"red"}

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

# Start scheduled function loops (performance optimization)
schedule function hagk:buff_loop 1t
schedule function hagk:weapon_loop 1t
