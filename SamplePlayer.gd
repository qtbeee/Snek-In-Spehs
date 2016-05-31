
extends SamplePlayer


func _ready():
	pass


func _on_Snek_eat():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("eat")

func _on_Room1Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room2Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room3Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room4Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room5Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room6Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Room7Door_unlock():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("unlock")

func _on_Snek_levelup():
	get_tree().get_root().get_node("Node2D/SamplePlayer").play("levelup")
