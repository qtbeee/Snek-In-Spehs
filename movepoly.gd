extends Sprite

func _ready():
	pass

func moveTo(pos):
	var sPos = self.get_pos()
	var dv   = pos - sPos
	if (dv.length() > 8):
		dv = 8 * dv.normalized()
	
	self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func rotHead(pos):
	var sPos = self.get_pos()
	var dv   = pos - sPos
	if (dv.length() > 8):
		dv = 8 * dv.normalized()
	
	#self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))	

func closeGap(pos, dist):
	var sPos = self.get_pos()
	var dp   = pos - sPos
	var len  = dp.length()
	var vect = dp / len
	var dv   = vect * (len - dist)
	
	self.set_pos(sPos + dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))

func hit():
	get_parent().hit()

func enemy_hit(enemy):
	get_parent().enemy_hit(enemy)

func level_up():
	get_parent().level_up()