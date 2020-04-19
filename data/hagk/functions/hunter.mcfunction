team leave @p[scores={hunter_buffer=1..}]
team join HUNTER @p[scores={hunter_buffer=1..}]
effect clear @p[scores={hunter_buffer=1..}]
gamemode adventure @p[team=HUNTER,gamemode=!adventure]
scoreboard players reset @p[scores={hunter_buffer=1..}] hunted_death
scoreboard players reset @p[scores={hunter_buffer=1..}] hunter_buffer