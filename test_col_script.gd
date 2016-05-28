
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(dt):
	var mpos = get_global_mouse_pos()
	var spos = self.get_pos()
	var dv   = mpos - spos
	if (dv.length() > 8):
		dv = 8 * dv.normalized()
	
	self.move(dv)
	self.set_rot(-dv.angle_to(Vector2(1, 0)))