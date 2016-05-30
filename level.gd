extends Node2D

#var camera
onready var snake = get_node("Snek")
onready var deathmsg = get_node("HUD/Control/DeathMessage")

func _on_Snek_death():
	deathmsg.set_text("YOU DIED")