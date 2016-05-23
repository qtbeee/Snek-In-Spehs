extends KinematicBody2D

signal death
signal eat

var pos
var vel
var b = 0
var health
var level
var tummy
var head
var camera
var nextZ
var timer
var color_names = ["black", "red", "orange", "yellow", "green", "blue", "indigo", "violet", "white"]
var colors = {
				"black":Color(0,0,0), 
				"red":Color(1,0,0), 
				"orange":Color(1,0.5,0), 
				"yellow":Color(1,1,0), 
				"green":Color(0,1,0), 
				"blue":Color(0,0,1), 
				"indigo":Color(0.5,0,1), 
				"violet":Color(1,0,1), 
				"white":Color(2,2,2)}

# Averaged over the last 60 frames ~ 1 seconds
var avgVel     = Vector2(0, 0)
var _velArr    = []
var _avgIndex  = 0
var _avgFrames = 60
var _avgMult   = 1.0 / _avgFrames

const HEALTH_MAX = 5
const MAX_LEVEL = 9
const TUMMY_FULL = 1
const nonsnakenodes = 1
const TIMER_MAX = 5

func _ready():
	pos = Vector2(0, 0)
	vel = Vector2(0, 0)

	health = HEALTH_MAX
	level = 1
	tummy = 0
	#set_shape(0, get_node("CollisionShape2D").get_shape())
	head = get_node("Ugh")
	camera = get_node("Camera")
	nextZ = -2
	
	for i in range(3):
		add_snake_segment()
	change_color(color_names[level-1])
	set_process(true)

func _fixed_process(delta):
	if timer <= delta:
		shoot()
		timer = TIMER_MAX
	else:
		timer -= delta

func _process(delta):
	var mpos = get_global_mouse_pos()
	head.moveTo(mpos)
	camera.set_pos(head.get_pos())
	pos = head.get_pos()
	vel = head.velocity
	
	var last = head
	for i in range(2, get_child_count()):
		var next = get_child(i)
		next.closeGap(last.get_pos(), 34)
		last = next
	
	computeAvgVelocity()

	if(Input.is_mouse_button_pressed(BUTTON_LEFT) &&  b > 0 ):
		head.boost(mpos);
		b -= 3
		print(str("Boost count:", b));
	
	elif(b < 200):
		b += 1
		print(str("Boost count:", b));

func add_snake_segment():
	var lastSeg = get_child(get_child_count() - 1)
	var nextSeg = lastSeg.duplicate()
	
	nextSeg.set_z(nextZ);
	nextZ = nextZ - 1
	
	add_child(nextSeg)

func reset_health():
	for child in get_children():
		child.show()
	health = HEALTH_MAX

func restore_health():
	if health != HEALTH_MAX:
		get_child(health+nonsnakenodes).show()
		health += 1

func level_up():
	reset_health()
	level += 1
	if level > MAX_LEVEL:
		level = MAX_LEVEL
	change_color(color_names[level-1])

func hit():
	health -= 1
	if health <= 0:
		get_node("Ugh/DeathDots").set_emitting(true)
		emit_signal("death")
		set_process(false)
		return
	get_child(health+nonsnakenodes).hide()


func enemy_hit(enemy_node):
	var enemy_lvl = enemy_node.get_level()
	if enemy_lvl < level:
		enemy_node.get_eaten()
		tummy += enemy_lvl
		if tummy >= TUMMY_FULL:
			tummy -= TUMMY_FULL
			restore_health()
	else:
		hit()

func change_color(color):
	get_node("Ugh/Head").set_modulate(colors[color])
	for child in get_children():
		if child.has_method("set_modulate"):
			child.set_modulate(colors[color])

func computeAvgVelocity():
	if (_velArr.size() == _avgFrames):
		var lastVel = _velArr[_avgIndex]
		_velArr[_avgIndex] = vel
		avgVel -= _avgMult * lastVel
	else:
		_velArr.append(vel)
	
	avgVel += (_avgMult * vel)
	
	_avgIndex += 1
	if (_avgIndex >= _avgFrames):
		_avgIndex = 0
