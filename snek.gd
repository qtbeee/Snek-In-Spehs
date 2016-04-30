
extends KinematicBody2D

signal death
signal eat
var health
var level
var tummy
var color_names = ["black", "red", "orange", "yellow", "green", "blue", "indigo", "violet", "white"]
var colors = {"black":Color(0,0,0), 
				"red":Color(1,0,0), 
				"orange":Color(1,0.5,0), 
				"yellow":Color(1,1,0), 
				"green":Color(0,1,0), 
				"blue":Color(0,0,1), 
				"indigo":Color(0.5,0,1), 
				"violet":Color(1,0,1), 
				"white":Color(2,2,2)}

const HEALTH_MAX = 5
const MAX_LEVEL = 9
const TUMMY_FULL = 1

func _ready():
	health = HEALTH_MAX
	level = 1
	tummy = 0
	set_shape(0, get_node("CollisionShape2D").get_shape())
	change_color(color_names[level-1])
	#set_fixed_process(true)

func reset_health():
	for child in get_children():
		child.show()
	health = HEALTH_MAX

func restore_health():
	if health != MAX_LEVEL:
		get_child(health).show()
		health += 1

func level_up():
	reset_health()
	level += 1
	if level > MAX_LEVEL:
		level = MAX_LEVEL
	change_color(color_names[level-1])

func hit():
	health -= 1
	if health == 0:
		get_node("DeathDots").set_emitting(true)
		emit_signal("death")
		return
	get_child(health).hide()

func enemy_hit(enemy_node):
	var enemy_lvl = enemy_node.get_level()
	if enemy_node.get_level() < level:
		enemy_node.get_eaten()
		tummy += enemy_lvl
		if tummy >= TUMMY_FULL:
			tummy -= TUMMY_FULL
			restore_health()
	else:
		hit()

func change_color(color):
	for child in get_children():
		if child.has_method("set_modulate"):
			child.set_modulate(colors[color])
