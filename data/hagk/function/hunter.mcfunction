# Process players joining the HUNTER team via hunter_buffer
# Set hunter_buffer score to 1 to join hunters

execute as @a[scores={hunter_buffer=1..}] run function hagk:prepare_player
execute as @a[scores={hunter_buffer=1..}] run function hagk:clear_items
execute as @a[scores={hunter_buffer=1..}] run team leave @s
execute as @a[scores={hunter_buffer=1..}] run team join HUNTER @s
gamemode adventure @a[tag=hagk.participant,team=HUNTER,gamemode=!adventure]

# A hunter receives one persistent tagged trident. Pearls are replenished separately.
give @a[tag=hagk.participant,scores={hunter_buffer=1..},team=HUNTER] minecraft:trident[custom_name={text:"TriPoke2",color:"light_purple",italic:true},lore=[{text:"This kills people",color:"black",obfuscated:true}],unbreakable={},custom_data={hagk:{item:"hunter_trident"}},enchantments={unbreaking:3,loyalty:3,impaling:10,channeling:10}] 1

scoreboard players reset @a[scores={hunter_buffer=1..}] hunted_death
scoreboard players reset @a[scores={hunter_buffer=1..}] hunted_buffer
scoreboard players reset @a[scores={hunter_buffer=1..}] hunter_buffer
