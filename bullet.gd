
extends Sprite

var path
var speed

func set_speed(new_speed):
	speed = new_speed

func stop():
	set_speed(0)

func _fixed_process(delta):
	var curr_offset = path.get_unit_offset()
	path.set_unit_offset(curr_offset + (speed*delta))
	if path.get_unit_offset() >= 1.0:
		queue_free()
	
func _ready():
	speed = 0.5
	path = get_parent().get_parent()
	set_fixed_process(true)

func _on_Area2D_body_enter(body):
	if body.has_method("hit"):
		body.hit()
		queue_free()