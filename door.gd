
extends StaticBody2D
signal unlock

var blocking = true
onready var snek = get_tree().get_root().get_child(0).get_node("Snek")
onready var sprite = get_node("Sprite")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if get_child_count() == 2:
		sprite.set_opacity(.25)
		add_collision_exception_with(snek.get_child(1))
		set_fixed_process(false)
		emit_signal("unlock")