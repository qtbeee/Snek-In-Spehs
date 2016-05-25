
extends Panel

onready var snek = get_parent().get_parent().get_parent().get_node("Snek")
var width = 200

const SCALE = 2
const height = 42

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	width = snek.get("b") * SCALE
	set_size(Vector2(width, height))

