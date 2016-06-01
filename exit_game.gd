extends Sprite

func _ready():
	pass

func _on_Area2D_body_enter(body):
	get_tree().quit()
