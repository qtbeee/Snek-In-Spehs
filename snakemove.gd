extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	pass

func moveTo(pos):
	var sPos = self.get_pos()
	var dv   = pos - sPos
	if (dv.length() > 8):
		dv = 8 * dv.normalized()
	
	self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func closeGap(pos, dist):
	var sPos = self.get_pos()
	var dp   = pos - sPos
	var len  = dp.length()
	var vect = dp / len
	var dv   = vect * (len - dist)
	
	self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))