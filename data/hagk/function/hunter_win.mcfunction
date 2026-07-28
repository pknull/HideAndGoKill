title @a[tag=hagk.participant] times 20 100 20
title @a[tag=hagk.participant] subtitle {"text":"No hunted players remain.","color":"gray"}
title @a[tag=hagk.participant] title {"text":"Hunters Win","color":"red"}
tellraw @a[tag=hagk.participant] {"text":"The final hunted player has fallen.","color":"red"}
function hagk:cleanup
