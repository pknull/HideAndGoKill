# Stop Hide and Go Kill game and restore world state
# Run to end the game: /function hagk:stop

execute unless score #game hagk_state matches 1 run tellraw @s {"text":"Hide and Go Kill is not running.","color":"yellow"}
execute unless score #game hagk_state matches 1 run return 0

title @a[tag=hagk.participant] times 20 60 20
title @a[tag=hagk.participant] subtitle {"text":"World and player state restored.","color":"gray"}
title @a[tag=hagk.participant] title {"text":"Game Stopped","color":"dark_green"}

function hagk:cleanup
