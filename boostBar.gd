
extends ProgressBar

onready var snek = get_parent().get_parent().get_node("snek")

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	set("progress", 0.5)
	pass
