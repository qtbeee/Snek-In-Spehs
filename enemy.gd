
extends Sprite

var path
var speed

const LEVEL = 1

func set_speed(new_speed):
	speed = new_speed

func stop():
	set_speed(0)

func get_level():
	return LEVEL

func _fixed_process(delta):
	var curr_offset = path.get_unit_offset()
	path.set_unit_offset(curr_offset + (speed*delta))
	
func _ready():
	speed = 0.25
	path = get_parent().get_parent()
	set_fixed_process(true)

func _on_Area2D_body_enter(body):
	if body.has_method("enemy_hit2"):
		body.enemy_hit2(self)