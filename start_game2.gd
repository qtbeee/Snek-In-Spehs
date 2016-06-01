
extends Area2D

func _ready():
	pass

func _on_Area2D_body_enter(body):
	print("lolno")
	get_tree().change_scene("res://level.scn")