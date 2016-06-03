extends Node2D

#var camera
onready var snake = get_node("Snek")
onready var deathmsg = get_node("HUD/Control/Message")
onready var winstate = get_node("WinningStuff")

func _on_Snek_death():
	deathmsg.set_text("YOU DIED")
	get_node("HUD/Quit").show()
	get_node("HUD/Restart").show()

func _on_Snek_win():
	deathmsg.set_text("YOU ARE MY WINNER TODAY!")
	winstate.get_node("Particles2D").set_emitting(true)
	get_node("HUD/Quit").show()
	get_node("HUD/Restart").show()

func _on_Restart_pressed():
	get_tree().reload_current_scene()

func _on_Quit_pressed():
	get_tree().quit()
