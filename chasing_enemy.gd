extends KinematicBody2D

onready var mainnode = get_tree().get_root().get_child(0)
onready var target  = mainnode.get_node("Snek")
export(String, "chase", "flank_left", "flank_right", "flank_switch") var type = "chase"
var side    = "left"
var dist    = 100
export var shooter = false
export(int, 1, 8) var level = 2

onready var animations = get_node("AnimationPlayer")

var bTime  = 0
var bDelay = 1.5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_process(true)
	pass

func _process(delta):
	if (target == null):
		return
	
	if (shooter):
		bTime += delta
		if (bTime > bDelay):
			bTime -= bDelay
			shootAtTarget()
	
	if (type == "chase"):
		chaseTarget()
	elif (type == "flank_left"):
		side = "left"
		flankTarget(false)
	elif (type == "flank_right"):
		side = "right"
		flankTarget(false)
	elif (type == "flank_switch"):
		flankTarget(true)

func chaseTarget():
	moveToPos(target.pos)

func flankTarget(sw):
	var pos     = target.pos
	var vel     = target.avgVel
	var dir     = vel.normalized()
	var tangent = Vector2(dir.y, -dir.x)
	var offset  = dist * tangent
	var lPos    = pos + offset
	var rPos    = pos - offset
	
	if (sw):
		var d1 = self.get_pos().distance_squared_to(lPos)
		var d2 = self.get_pos().distance_squared_to(rPos)
		
		var rl = d2 - d1
		if (rl < -16 && side == "left"):
			side = "right"
		elif (rl > 16 && side == "right"):
			side = "left"
			
		if (side == "left"):
			moveToPos(lPos)
		else:
			moveToPos(rPos)
	else:
		if (side == "left"):
			moveToPos(lPos)
		elif (side == "right"):
			moveToPos(rPos)

func moveToPos(pos):
	var sPos = get_global_pos()
	var dv   = pos - sPos
	if (dv.length() > 6):
		dv = 6 * dv.normalized()
	
	self.move(dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func shootAtTarget():
	var dir    = target.pos - self.get_pos()
	var bullet = preload("res://bullet.scn").instance()
	mainnode.add_child(bullet)
	#bullet.add_collision_exception_with(self)
	bullet.set_pos(get_global_pos())
	bullet.set_direction(dir)
	bullet.set_speed(200)

func setTarget(tar):
	target = tar

func setType(t):
	type = t

func setDist(d):
	dist = d

func _on_Area2D_body_enter( body ):
	if body.has_method("enemy_hit"):
		body.enemy_hit(self)

func get_eaten():
	animations.play("eaten")


func _on_VisibilityEnabler2D_enter_screen():
	set_process(true)
