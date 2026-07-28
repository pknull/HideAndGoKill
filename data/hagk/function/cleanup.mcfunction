# Stop loops first so no supplies or effects are applied during cleanup.
schedule clear hagk:buff_loop
schedule clear hagk:supply_loop
schedule clear hagk:weapon_loop

# Restore the world-global state captured by start.
function hagk:restore_world

# Restore online participants. Offline participants are handled by tick after reconnecting.
execute as @a[tag=hagk.participant] run function hagk:restore_player

# Remove tagged game items dropped in the world and tagged thrown tridents.
execute as @e[type=minecraft:item] if items entity @s contents minecraft:trident[custom_data~{hagk:{item:"hunter_trident"}}] run kill @s
execute as @e[type=minecraft:item] if items entity @s contents minecraft:trident[custom_data~{hunter:1b}] run kill @s
execute as @e[type=minecraft:item] if items entity @s contents minecraft:ender_pearl[custom_data~{hagk:{item:"hunter_pearl"}}] run kill @s
execute as @e[type=minecraft:item] if items entity @s contents minecraft:ender_pearl[custom_data~{hagk:{item:"hunted_pearl"}}] run kill @s
execute as @e[type=minecraft:trident] if items entity @s contents minecraft:trident[custom_data~{hagk:{item:"hunter_trident"}}] run kill @s

# Teams include offline members, so empty them after restoring online players.
team empty HUNTER
team empty HUNTED

scoreboard players set #game hagk_state 0
data remove storage hagk:state time
