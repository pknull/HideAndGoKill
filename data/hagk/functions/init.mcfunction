# Initialize scoreboards and teams for Hide and Go Kill
# Run once before starting the game: /function hagk:init

# Scoreboard objectives
scoreboard objectives add hunter_buffer dummy
scoreboard objectives add hunted_buffer dummy
scoreboard objectives add hunted_death deathCount
scoreboard objectives add hunted_leave dummy

# Create teams with hidden nametags
team add HUNTER
team modify HUNTER nametagVisibility never
team add HUNTED
team modify HUNTED nametagVisibility never
