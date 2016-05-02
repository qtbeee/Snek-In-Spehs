
extends Sprite

func _ready():
	pass

func _on_Area2D_body_enter(body):
	if body.has_method("level_up"):
		body.level_up()
		get_parent().queue_free()
		#wanna free this node cause its been eaten, bruh.
