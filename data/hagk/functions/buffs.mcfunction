# Apply buffs to all team members
# HUNTER: saturation, strength, regeneration
# HUNTED: saturation only
execute as @a[team=HUNTER] run effect give @s minecraft:saturation 5 1 true
execute as @a[team=HUNTED] run effect give @s minecraft:saturation 5 1 true
execute as @a[team=HUNTER] run effect give @s minecraft:strength 5 10 true
execute as @a[team=HUNTER] run effect give @s minecraft:regeneration 5 5 true
