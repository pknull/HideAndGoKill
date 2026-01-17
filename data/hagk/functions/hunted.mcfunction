# Process players joining the HUNTED team via hunted_buffer
# Set hunted_buffer score to 1 to join hunted

execute as @a[scores={hunted_buffer=1..}] run team leave @s
execute as @a[scores={hunted_buffer=1..}] run team join HUNTED @s
execute as @a[scores={hunted_buffer=1..}] run effect clear @s
gamemode adventure @a[team=HUNTED,gamemode=!adventure]

# Give ender pearl to new hunted players who don't have one (1.21+ syntax)
execute as @a[scores={hunted_buffer=1..},gamemode=adventure] unless items entity @s container.* minecraft:ender_pearl run give @s minecraft:ender_pearl 1

scoreboard players reset @a[scores={hunted_buffer=1..}] hunted_death
scoreboard players reset @a[scores={hunted_buffer=1..}] hunted_buffer
