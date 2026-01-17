# Process players joining the HUNTER team via hunter_buffer
# Set hunter_buffer score to 1 to join hunters

execute as @a[scores={hunter_buffer=1..}] run team leave @s
execute as @a[scores={hunter_buffer=1..}] run team join HUNTER @s
execute as @a[scores={hunter_buffer=1..}] run effect clear @s
gamemode adventure @a[team=HUNTER,gamemode=!adventure]
scoreboard players reset @a[scores={hunter_buffer=1..}] hunted_death
scoreboard players reset @a[scores={hunter_buffer=1..}] hunter_buffer
