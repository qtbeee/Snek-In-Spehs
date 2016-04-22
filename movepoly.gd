extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	pass

func _process(delta):
	var mpos = get_viewport().get_mouse_pos()
	var pos  = self.get_pos()
	var dv   = mpos - pos
	if (dv.length() > 1024):
		dv = 1024 * dv.normalized()
	
	if (dv.dot(self.get_linear_velocity()) < 0):
		dv = 1024 * dv.normalized()
	
	self.set_applied_force(dv)