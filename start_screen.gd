extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var snek = get_node("Snek")
	snek.change_color("yellow")
	pass


