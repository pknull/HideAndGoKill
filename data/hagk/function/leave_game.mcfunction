# Handle either role leaving via the hunted_leave compatibility objective.

execute as @a[scores={hunted_leave=1..}] run function hagk:restore_player
