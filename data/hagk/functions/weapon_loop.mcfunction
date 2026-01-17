# Scheduled weapon check loop
# Runs every 20 ticks (1 second) instead of every tick for performance

function hagk:weapons
schedule function hagk:weapon_loop 20t
