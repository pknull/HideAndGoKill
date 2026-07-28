# Replenish hunter consumables once per second while a game is active.
execute unless score #game hagk_state matches 1 run return 0
function hagk:supplies
schedule function hagk:supply_loop 20t replace
