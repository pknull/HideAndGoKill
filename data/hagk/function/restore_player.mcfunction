# Restore one online participant. Called as that player.
function hagk:clear_items

effect clear @s minecraft:saturation
effect clear @s minecraft:strength
effect clear @s minecraft:regeneration

execute if entity @s[tag=hagk.was_survival] run gamemode survival @s
execute if entity @s[tag=hagk.was_creative] run gamemode creative @s
execute if entity @s[tag=hagk.was_adventure] run gamemode adventure @s
execute if entity @s[tag=hagk.was_spectator] run gamemode spectator @s
execute unless entity @s[tag=hagk.was_survival] unless entity @s[tag=hagk.was_creative] unless entity @s[tag=hagk.was_adventure] unless entity @s[tag=hagk.was_spectator] run gamemode survival @s

team leave @s
tag @s remove hagk.participant
tag @s remove hagk.was_survival
tag @s remove hagk.was_creative
tag @s remove hagk.was_adventure
tag @s remove hagk.was_spectator

scoreboard players reset @s hunter_buffer
scoreboard players reset @s hunted_buffer
scoreboard players reset @s hunted_death
scoreboard players reset @s hunted_leave
