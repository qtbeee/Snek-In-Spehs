
extends Sprite

var path
var speed

func set_speed(new_speed):
	speed = new_speed

func _fixed_process(delta):
	path.set_offset(path.get_offset()+(speed*delta))
	
func _ready():
	speed = 100
	path = get_parent().get_parent()
	set_fixed_process(true)

func _on_Area2D_body_enter(body):
	if body.has_method("hit"):
		body.hit()