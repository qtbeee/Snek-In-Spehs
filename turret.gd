
extends Area2D

#var path
#var speed
var bullet
var timer
var animations
const LEVEL = 1
const TIMER_MAX = 200

func _ready():
	bullet = preload("res://bullet.scn")
	timer = TIMER_MAX
	animations = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if timer <= delta:
		shoot()
		timer = TIMER_MAX + (timer - delta)
	else:
		timer -= delta

func shoot():
	animations.play("shoot")

func bullet_shoot():
	var bul = bullet.instance()
	bul.set_speed(10)
	bul.set_direction(Vector2(0, 1))#im not sure anymoreeeee
	add_child(bul)
	

func stop():
	set_process(false)

func get_level():
	return LEVEL

func get_eaten():
	animations.play("eaten")

func _on_Turret_body_enter(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit(self)
