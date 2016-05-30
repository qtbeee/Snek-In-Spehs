extends Area2D

var direction
var speed = 0
var curpos

func _ready():
	curpos = Vector2(0, 0)

func _enter_tree():
	set_fixed_process(true)

func set_speed(new_speed):
	speed = new_speed

func set_direction(new_dir):
	direction = new_dir

func stop():
	set_speed(0)

func _fixed_process(delta):
	curpos = get_pos()
	set_pos(curpos + (direction * speed * delta))
	

func _on_Bullet_body_enter( body ):
	if body.has_method("hit"):
		body.hit()
	if body.has_method("shootAtTarget"):
		return
	else:
		queue_free()
