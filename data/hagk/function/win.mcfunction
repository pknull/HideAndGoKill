execute unless score #game hagk_state matches 1 run return 0

# An empty server/participant list ends silently.
execute unless entity @a[tag=hagk.participant] run function hagk:cleanup
execute unless score #game hagk_state matches 1 run return 0

# A side wins when it is the only remaining populated team.
execute unless entity @a[tag=hagk.participant,team=HUNTER] if entity @a[tag=hagk.participant,team=HUNTED] run function hagk:hunted_win
execute unless score #game hagk_state matches 1 run return 0
execute unless entity @a[tag=hagk.participant,team=HUNTED] if entity @a[tag=hagk.participant,team=HUNTER] run function hagk:hunter_win
