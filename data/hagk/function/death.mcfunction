# Handle hunted player deaths - convert them to hunters
# hunted_death is a deathCount scoreboard, auto-increments on death

# When a hunted player dies, set their hunter_buffer to convert them to hunter team
execute if score #game hagk_state matches 1 as @a[tag=hagk.participant,team=HUNTED,scores={hunted_death=1..}] run scoreboard players set @s hunter_buffer 1
