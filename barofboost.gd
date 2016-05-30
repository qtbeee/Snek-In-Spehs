
extends Panel

onready var snek = get_tree().get_root().get_child(0).get_node("Snek")
onready var control = get_parent()
var width = 200

const SCALE = 2
const HEIGHT = 42

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var height = get_viewport().get_rect().size.height - HEIGHT
	get_parent().set_pos(Vector2(control.get_pos().x, height))
	width = snek.get("b") * SCALE
	set_size(Vector2(width, height))

