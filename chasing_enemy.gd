extends KinematicBody2D

var target  = null
var type    = "chase"
var side    = "left"
var dist    = 100
var shooter = false

var bTime  = 0
var bDelay = 1.5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	type   = "chase"
	set_process(true)

func _process(delta):
	if (target == null):
		pass
	
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
	var sPos = self.get_pos()
	var dv   = pos - sPos
	if (dv.length() > 6):
		dv = 6 * dv.normalized()
	
	self.move(dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func shootAtTarget():
	var dir    = target.pos - self.get_pos()
	var bullet = preload("res://BulletController.scn").instance()
	get_parent().add_child(bullet)
	bullet.set_position(self.get_pos())
	bullet.fire(dir, 12, 3, 128)

func setTarget(tar):
	target = tar

func setType(t):
	type = t

func setDist(d):
	dist = d