extends Node2D

var rPos
var rVel
var bullet
var separation
var maxSep
var totalTime
var liveTime

func _ready():
	rPos       = self.get_pos()
	rVel       = Vector2(0, 4)
	bullet     = self.get_node("Polygon2D")
	separation = 0
	maxSep     = 64
	totalTime  = 0
	liveTime   = 5
	remove_child(bullet)
	addBullets(5)
	set_process(true)

func addBullets(num):
	for i in range(num):
		var dup = bullet.duplicate()
		self.add_child(dup)

func _process(dt):
	totalTime += dt
	
	rPos       += rVel
	var xOffset = 16 * sin(14 * totalTime)
	var newPos  = Vector2(rPos.x + xOffset, rPos.y)
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
			
			var pos = Vector2(oSign * ((i + 1) / 2) * separation, 0)
			b.set_pos(pos)
	else:
		pass