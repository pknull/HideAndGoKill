# Scheduled buff application loop
# Runs every 40 ticks (2 seconds) instead of every tick for performance

function hagk:buffs
schedule function hagk:buff_loop 40t
