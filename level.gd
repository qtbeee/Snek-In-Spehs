extends Node2D

#var camera
var snake

func _ready():
	#camera = get_node("Camera")
	snake = get_node("snek")
	
	var bullet = get_node("Bullet")
	remove_child(bullet)
	
	var ce = get_node("ChasingEnemy")
	ce.setTarget(snake)
	ce.setType("flank_switch")
	
	set_process(true)

func _on_snek_death():
	get_node("Label").set_text("YOU DIED")
	var bullet = get_node("Bullet/PathFollow2D/Area2D/Bullet")
	if bullet != null:
		bullet.stop()
	var food = get_node("testmovingfood/PathFollow2D/Area2D/Food")
	if food != null:
		food.stop()

#func _process(delta):
	#camera.set_pos(snake.get_pos())
