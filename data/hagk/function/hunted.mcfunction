# Process players joining the HUNTED team via hunted_buffer
# Set hunted_buffer score to 1 to join hunted

execute as @a[scores={hunted_buffer=1..}] run function hagk:prepare_player
execute as @a[scores={hunted_buffer=1..}] run function hagk:clear_items
execute as @a[scores={hunted_buffer=1..}] run team leave @s
execute as @a[scores={hunted_buffer=1..}] run team join HUNTED @s
gamemode adventure @a[tag=hagk.participant,team=HUNTED,gamemode=!adventure]

# Hunted players receive one tagged pearl when assigned.
give @a[tag=hagk.participant,scores={hunted_buffer=1..},team=HUNTED] minecraft:ender_pearl[custom_data={hagk:{item:"hunted_pearl"}}] 1

scoreboard players reset @a[scores={hunted_buffer=1..}] hunted_death
scoreboard players reset @a[scores={hunted_buffer=1..}] hunter_buffer
scoreboard players reset @a[scores={hunted_buffer=1..}] hunted_buffer
