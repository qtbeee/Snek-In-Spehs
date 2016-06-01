extends Node2D

#var camera
onready var snake = get_node("Snek")
onready var deathmsg = get_node("HUD/Control/DeathMessage")
onready var winstate = get_node("WinningStuff")

func _on_Snek_death():
	deathmsg.set_text("YOU DIED")

func _on_Snek_win():
	deathmsg.set_text("YOU WIN!")
	winstate.get_node("Particles2D").set_emitting(true)
	