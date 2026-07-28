# Load-time initialization. Existing objectives and teams are preserved.
scoreboard objectives add hunter_buffer dummy
scoreboard objectives add hunted_buffer dummy
scoreboard objectives add hunted_death deathCount
scoreboard objectives add hunted_leave dummy
scoreboard objectives add hagk_state dummy
scoreboard objectives add hagk_world dummy

# Fake-player state survives /reload. 0 = lobby/stopped, 1 = running.
scoreboard players add #game hagk_state 0

# Game teams
team add HUNTER
team modify HUNTER nametagVisibility never
team modify HUNTER friendlyFire false
team add HUNTED
team modify HUNTED nametagVisibility never
team modify HUNTED friendlyFire false

# Resume scheduled loops if the pack is reloaded during a game.
schedule clear hagk:weapon_loop
execute if score #game hagk_state matches 1 run schedule function hagk:buff_loop 1t replace
execute if score #game hagk_state matches 1 run schedule function hagk:supply_loop 1t replace
