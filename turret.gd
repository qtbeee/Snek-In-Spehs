extends Area2D

export(int, 1, 8) var level = 1
export(String, "down", "downleft", "downleftspread", "downright", "downrightspread", "left", "leftspread", "right", "rightspread", "up", "upspread", "upleft", "upleftspread", "upright", "uprightspread", "upspread", "spreadshot", "crazy") var firing_pattern = "down"

var commonanimations
var animations
onready var mainnode = get_tree().get_root().get_child(0)

func _ready():
	commonanimations = get_node("CommonAnimations")
	animations = get_node("SelfAnimation")
	var animname = str("res://shotgun_", firing_pattern, ".anm")
	print(animname)
	var anim = load(animname)
	animations.add_animation(firing_pattern, anim)
	animations.play(firing_pattern)

func bullet_shoot(direction):
	var bullet = preload("res://bullet.scn").instance()
	mainnode.add_child(bullet)
	bullet.set_pos(get_global_pos())
	bullet.set_direction(direction)
	bullet.set_speed(200)

func shoot_8():
	bullet_shoot(Vector2(1,0))
	bullet_shoot(Vector2(-1,0))
	bullet_shoot(Vector2(0,1))
	bullet_shoot(Vector2(0,-1))
	bullet_shoot(Vector2(1,1))
	bullet_shoot(Vector2(-1,1))
	bullet_shoot(Vector2(1,-1))
	bullet_shoot(Vector2(-1,-1))

func shotgun_upright():
	bullet_shoot(Vector2(1, -0.5))
	bullet_shoot(Vector2(1, -1))
	bullet_shoot(Vector2(0.5, -1))

func shotgun_downright():
	bullet_shoot(Vector2(1, 0.5))
	bullet_shoot(Vector2(1, 1))
	bullet_shoot(Vector2(0.5, 1))

func shotgun_upleft():
	bullet_shoot(Vector2(-1, -0.5))
	bullet_shoot(Vector2(-1, -1))
	bullet_shoot(Vector2(-0.5, -1))

func shotgun_downleft():
	bullet_shoot(Vector2(-1, 0.5))
	bullet_shoot(Vector2(-1, 1))
	bullet_shoot(Vector2(-0.5, 1))

func shotgun_up():
	bullet_shoot(Vector2(0, -1))
	bullet_shoot(Vector2(0.5, -1))
	bullet_shoot(Vector2(-0.5, -1))

func shotgun_down():
	bullet_shoot(Vector2(0, 1))
	bullet_shoot(Vector2(0.5, 1))
	bullet_shoot(Vector2(-0.5, 1))

func shotgun_left():
	bullet_shoot(Vector2(1, 0.5))
	bullet_shoot(Vector2(1, 0))
	bullet_shoot(Vector2(1, -0.5))

func shotgun_right():
	bullet_shoot(Vector2(-1, 0.5))
	bullet_shoot(Vector2(-1, 0))
	bullet_shoot(Vector2(-1, -0.5))

func shotgun_upleftspread():
	bullet_shoot(Vector2(-1, -1))
	bullet_shoot(Vector2(-1, -0.5))
	bullet_shoot(Vector2(-0.5, -1))
	bullet_shoot(Vector2(-1, -0.1))
	bullet_shoot(Vector2(-0.1, -1))

func shotgun_downleftspread():
	bullet_shoot(Vector2(-1, 1))
	bullet_shoot(Vector2(-1, 0.5))
	bullet_shoot(Vector2(-0.5, 1))
	bullet_shoot(Vector2(-1, 0.1))
	bullet_shoot(Vector2(-0.1, 1))

func shotgun_uprightspread():
	bullet_shoot(Vector2(1, -1))
	bullet_shoot(Vector2(1, -0.5))
	bullet_shoot(Vector2(0.5, -1))
	bullet_shoot(Vector2(1, -0.1))
	bullet_shoot(Vector2(0.1, -1))

func shotgun_downrightspread():
	bullet_shoot(Vector2(1, 1))
	bullet_shoot(Vector2(1, 0.5))
	bullet_shoot(Vector2(0.5, 1))
	bullet_shoot(Vector2(1, 0.1))
	bullet_shoot(Vector2(0.1, 1))

func shotgun_upspread():
	bullet_shoot(Vector2(0, -1))
	bullet_shoot(Vector2(0.33, -1))
	bullet_shoot(Vector2(-0.66, -1))
	bullet_shoot(Vector2(-0.33, -1))
	bullet_shoot(Vector2(0.66, -1))

func shotgun_leftspread():
	bullet_shoot(Vector2(-1, 0))
	bullet_shoot(Vector2(-1, 0.33))
	bullet_shoot(Vector2(-1, -0.33))
	bullet_shoot(Vector2(-1, 0.66))
	bullet_shoot(Vector2(-1, -0.66))

func shotgun_rightspread():
	bullet_shoot(Vector2(1, 0))
	bullet_shoot(Vector2(1, 0.33))
	bullet_shoot(Vector2(1, -0.33))
	bullet_shoot(Vector2(1, 0.66))
	bullet_shoot(Vector2(1, -0.66))

func shotgun_crazy():
	bullet_shoot(Vector2(0, -1))
	bullet_shoot(Vector2(.5, -1))
	bullet_shoot(Vector2(1, -1))
	bullet_shoot(Vector2(1, -.5))
	bullet_shoot(Vector2(1, 0))
	bullet_shoot(Vector2(-1, 0))
	bullet_shoot(Vector2(-1, -.5))
	bullet_shoot(Vector2(-1, -1))
	bullet_shoot(Vector2(-.5, -1))
	bullet_shoot(Vector2(0, 1))
	bullet_shoot(Vector2(-.5, 1))
	bullet_shoot(Vector2(-1, 1))
	bullet_shoot(Vector2(-1, .5))
	bullet_shoot(Vector2(-1, 0))
	bullet_shoot(Vector2(1, 0))
	bullet_shoot(Vector2(1, .5))
	bullet_shoot(Vector2(1, 1))
	bullet_shoot(Vector2(.5, 1))



func stop():
	animations.stop()

func get_eaten():
	stop()
	commonanimations.play("eaten")

func _on_Turret_body_enter(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit(self)
