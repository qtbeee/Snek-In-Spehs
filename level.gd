
extends Node2D

func _ready():
	set_process(true)

func _on_snek_death():
	get_node("Label").set_text("YOU DIED")
	var bullet = get_node("Bullet/PathFollow2D/Area2D/Bullet")
	if bullet != null:
		bullet.stop()
	var food = get_node("testmovingfood/PathFollow2D/Area2D/Food")
	if food != null:
		food.stop()
