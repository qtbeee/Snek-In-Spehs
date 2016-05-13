
extends Area2D

export(int, 1, 8) var level = 1

#var path
#var speed
var timer
var commonanimations
var animations
const LEVEL = 1
const TIMER_MAX = 5

func _ready():
	timer = TIMER_MAX
	commonanimations = get_node("CommonAnimations")
	animations = get_node("SelfAnimation")
#	set_fixed_process(true)

#func _fixed_process(delta):
#	if timer <= delta:
#		shoot()
#		timer = TIMER_MAX
#	else:
#		timer -= delta

#func shoot():
#	animations.play("shoot")
	#animations. i dont know how to do thisssss

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

func shotgun_up():
	bullet_shoot(Vector2(0, -1))
	bullet_shoot(Vector2(0.5, -1))
	bullet_shoot(Vector2(-0.5, -1))

func shotgun_down():
	bullet_shoot(Vector2(0, 1))
	bullet_shoot(Vector2(0.5, 1))
	bullet_shoot(Vector2(-0.5, 1))

func shotgun_left():
	bullet_shoot(Vector2(-1, 0.5))
	bullet_shoot(Vector2(-1, 0))
	bullet_shoot(Vector2(-1, -0.5))

func shotgun_right():
	bullet_shoot(Vector2(1, 0.5))
	bullet_shoot(Vector2(1, 0))
	bullet_shoot(Vector2(1, -0.5))

func stop():
	set_process(false)

func get_level():
	return LEVEL

func get_eaten():
	commonanimations.play("eaten")

func _on_Turret_body_enter(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit(self)
