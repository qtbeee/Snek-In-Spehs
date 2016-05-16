extends KinematicBody2D

var target = null
var type   = "flank_left"
var side   = "left"
var dist   = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	if (target == null):
		pass
	
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
	moveToPos(target.get_pos())

func flankTarget(sw):
	var pos     = target.pos
	var vel     = target.avgVel
	var dir     = vel.normalized()
	var tangent = Vector2(dir.y, -dir.x)
	var offset  = dist * tangent
	var lPos    = pos + offset
	var rPos    = pos - offset
	
	if (sw):
		var d1 = pos.distance_squared_to(lPos)
		var d2 = pos.distance_squared_to(rPos)
		
		if (abs(d1 - d2) < 16):
			side = "left"
			moveToPos(lPos)
		else:
			side = "right"
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
	
	self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func setTarget(tar):
	target = tar

func setType(t):
	type = t

func setDist(d):
	dist = d