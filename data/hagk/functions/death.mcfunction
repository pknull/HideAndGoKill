# Handle hunted player deaths - convert them to hunters
# hunted_death is a deathCount scoreboard, auto-increments on death

# When a hunted player dies, set their hunter_buffer to convert them to hunter team
execute as @a[team=HUNTED,scores={hunted_death=1..}] run scoreboard players set @s hunter_buffer 1
