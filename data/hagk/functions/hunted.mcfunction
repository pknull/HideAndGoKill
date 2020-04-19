team leave @p[scores={hunted_buffer=1..}]
team join HUNTED @p[scores={hunted_buffer=1..}]
effect clear @p[scores={hunted_buffer=1..}]
gamemode adventure @p[team=HUNTED,gamemode=!adventure]
give @p[scores={hunted_buffer=1..},gamemode=adventure,nbt=!{Inventory:[{id:"minecraft:ender_pearl"}]}] minecraft:ender_pearl 1
scoreboard players reset @p[scores={hunted_buffer=1..}] hunted_death
scoreboard players reset @p[scores={hunted_buffer=1..}] hunted_buffer