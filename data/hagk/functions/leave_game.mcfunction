# Handle players leaving the game via hunted_leave score
# Set hunted_leave score to 1 to leave

gamemode survival @a[scores={hunted_leave=1..}]
execute as @a[scores={hunted_leave=1..}] run team leave @s
scoreboard players reset @a[scores={hunted_leave=1..}] hunted_leave
