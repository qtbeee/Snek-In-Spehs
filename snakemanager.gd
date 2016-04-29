extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var head
var camera
var nextZ

func _ready():
	head = self.get_child(1)
	camera = self.get_node("Camera")
	nextZ = -2
	
	for i in range(5):
		add_snake_segment()
		pass
	
	set_process(true)
	pass

func _process(delta):
	var mpos = get_global_mouse_pos()
	head.moveTo(mpos)
	#camera.set_pos(head.get_pos())
	
	var last = head
	for i in range(2, self.get_child_count()):
		var next = self.get_child(i)
		next.closeGap(last.get_pos(), 34)
		last = next
		pass

func add_snake_segment():
	var lastSeg = self.get_child(self.get_child_count() - 1)
	var nextSeg = lastSeg.duplicate()
	
	nextSeg.set_z(nextZ);
	nextZ = nextZ - 1
	
	self.add_child(nextSeg)