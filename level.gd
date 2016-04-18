
extends Node2D

func _ready():
	set_process(true)

func _on_snek_death():
	get_node("Label").set_text("YOU DIED")
	get_node("Bullet/PathFollow2D/Area2D/Bullet").set_speed(0)
