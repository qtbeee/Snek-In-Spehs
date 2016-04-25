extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var head
var camera

func _ready():
	head = self.get_child(0)
	camera = self.get_node("Head/Camera2D")
	
	for i in range(8):
		add_snake_segment()
		pass
		
	set_process(true)
	pass

func _process(delta):
	var mpos = get_global_mouse_pos()
	head.moveTo(mpos)
	
	var last = head
	for i in range(1, self.get_child_count()):
		var next = self.get_child(i)
		next.closeGap(last.get_pos(), 16)
		last = next
		pass

func add_snake_segment():
	var lastSeg = self.get_child(self.get_child_count() - 1)
	var nextSeg = lastSeg.duplicate()
	self.add_child(nextSeg)