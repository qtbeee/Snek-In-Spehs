extends Node2D

var rPos
var rVel
var bullet
var separation
var maxSep
var totalTime
var liveTime

var xPart
var yPart

func _ready():
	rPos       = self.get_pos()
	rVel       = Vector2(0, 4)
	bullet     = self.get_node("Sprite")
	separation = 0
	maxSep     = 64
	totalTime  = 0
	liveTime   = 5
	remove_child(bullet)
	set_process(true)

func fire(dir, speed, num, sep):
	rVel     = speed * dir.normalized()
	maxSep   = sep
	var norm = rVel.normalized()
	var tang = Vector2(-norm.y, norm.x)
	xPart = tang.dot(Vector2(1, 0))
	yPart = norm.dot(Vector2(1, 0))
	addBullets(num)

func addBullets(num):
	for i in range(num):
		var dup = bullet.duplicate()
		self.add_child(dup)

func _process(dt):
	totalTime += dt
	
	rPos       += rVel
	var offset  = 24 * sin(10 * totalTime)
	var xOff    = offset * xPart
	var yOff    = offset * yPart
	var newPos  = Vector2(rPos.x + xOff, rPos.y + yOff)
	self.set_pos(newPos)
	
	if separation < maxSep:
		separation += 1
		for i in range(self.get_child_count()):
			var b = self.get_child(i)
			var oSign
			if (i & 1):
				oSign = -1
			else:
				oSign = 1
			
			offset = oSign * ((i + 1) / 2) * separation
			xOff   = offset * xPart
			yOff   = offset * yPart
			b.set_pos(Vector2(xOff, yOff))
	else:
		pass

func set_position(pos):
	rPos = pos
	self.set_pos(pos)