# Explicit tick order: conversion, assignments, departures, then win detection.
function hagk:death
function hagk:hunter
function hagk:hunted
function hagk:leave_game
function hagk:win

# Restore players who reconnect after a game ended while they were offline.
execute if score #game hagk_state matches 0 as @a[tag=hagk.participant] run function hagk:restore_player
