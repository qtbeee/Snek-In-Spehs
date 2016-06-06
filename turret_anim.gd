extends AnimatedSprite

var tempElapsed = 0

func _ready():
	self.set_frame(47)
	set_process(true)
   
func _process(delta):
	tempElapsed = tempElapsed + delta
	if(tempElapsed > 0.015):
		if(get_frame() == self.get_sprite_frames().get_frame_count()-1):
			if(tempElapsed > 2.215):
				set_frame(0)
		else:
			self.set_frame(get_frame() + 1)
			tempElapsed = 0