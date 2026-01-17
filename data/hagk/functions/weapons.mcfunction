# Give weapons to hunters and manage item restrictions
# Hunters get: custom trident + ender pearl
# Non-hunters have hunter trident removed

# Give hunter trident to hunters who don't have one (1.21+ component syntax)
execute as @a[team=HUNTER,gamemode=adventure] unless items entity @s container.* minecraft:trident[custom_data~{hunter:1b}] run give @s minecraft:trident[custom_name={text:"TriPoke2",color:"light_purple",italic:true},lore=[{text:"This kills people",color:"black",obfuscated:true}],unbreakable={},custom_data={hunter:1b},enchantments={unbreaking:3,loyalty:3,impaling:10,channeling:10}] 1

# Give ender pearl to hunters who don't have one
execute as @a[team=HUNTER,gamemode=adventure] unless items entity @s container.* minecraft:ender_pearl run give @s minecraft:ender_pearl 1

# Remove hunter trident from non-hunters
clear @a[team=!HUNTER] minecraft:trident[custom_data~{hunter:1b}]
