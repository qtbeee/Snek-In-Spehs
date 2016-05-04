
extends Area2D

#var path
#var speed
var timer
var animations
const LEVEL = 1
const TIMER_MAX = 5

func _ready():
	timer = TIMER_MAX
	animations = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if timer <= delta:
		shoot()
		timer = TIMER_MAX
	else:
		timer -= delta

func shoot():
	animations.play("shoot")

func bullet_shoot(direction):
	var bullet = preload("res://bullet.scn").instance()
	add_child(bullet)
	bullet.set_pos(Vector2(0,0))
	bullet.set_direction(direction)
	bullet.set_speed(150)

func shoot_8():
	bullet_shoot(Vector2(1,0))
	bullet_shoot(Vector2(-1,0))
	bullet_shoot(Vector2(0,1))
	bullet_shoot(Vector2(0,-1))
	bullet_shoot(Vector2(1,1))
	bullet_shoot(Vector2(-1,1))
	bullet_shoot(Vector2(1,-1))
	bullet_shoot(Vector2(-1,-1))

func stop():
	set_process(false)

func get_level():
	return LEVEL

func get_eaten():
	animations.play("eaten")

func _on_Turret_body_enter(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit(self)
