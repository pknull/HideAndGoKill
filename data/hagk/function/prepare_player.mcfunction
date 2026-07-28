# Called as a player before their first game-team assignment.
execute if entity @s[tag=hagk.participant] run return 0

tag @s remove hagk.was_survival
tag @s remove hagk.was_creative
tag @s remove hagk.was_adventure
tag @s remove hagk.was_spectator

execute if entity @s[gamemode=survival] run tag @s add hagk.was_survival
execute if entity @s[gamemode=creative] run tag @s add hagk.was_creative
execute if entity @s[gamemode=adventure] run tag @s add hagk.was_adventure
execute if entity @s[gamemode=spectator] run tag @s add hagk.was_spectator
tag @s add hagk.participant
