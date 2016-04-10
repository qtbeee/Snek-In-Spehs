
extends Node2D

var screen_size
var pad_size

#speed of the Ball (in pixels/second
var Ball_speed = 80

#direction of the Ball (normal vector)
var direction = Vector2(-1,0)

#constant for pad speed (also in pixels/second)
const PAD_SPEED = 150


func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("Player1").get_texture().get_size()
	set_process(true)

func _process(delta):
	var Ball_pos = get_node("Ball").get_pos()
	var Player1_rect = Rect2( get_node("Player1").get_pos() - pad_size/2, pad_size )
	var Player2_rect = Rect2( get_node("Player2").get_pos() - pad_size/2, pad_size )
	Ball_pos+=direction*Ball_speed*delta
	if ( (Ball_pos.y<0 and direction.y <0) or (Ball_pos.y>screen_size.y and direction.y>0)):
		direction.y = -direction.y
	if ( (Player1_rect.has_point(Ball_pos) and direction.x < 0) or (Player2_rect.has_point(Ball_pos) and direction.x > 0)):
		direction.x=-direction.x
		Ball_speed*=1.1
		direction.y=randf()*2.0-1
		direction = direction.normalized()
	if (Ball_pos.x<0 or Ball_pos.x>screen_size.x):
		Ball_pos= screen_size*0.5 #Ball goes to screen center
		Ball_speed=80
		direction=Vector2(-1,0)
	get_node("Ball").set_pos(Ball_pos)
	#move Player1 pad
	var Player1_pos = get_node("Player1").get_pos()

	if (Player1_pos.y > 0 and Input.is_action_pressed("player1_move_up")):
		Player1_pos.y+=-PAD_SPEED*delta
	if (Player1_pos.y < screen_size.y and Input.is_action_pressed("player1_move_down")):
		Player1_pos.y+=PAD_SPEED*delta

	get_node("Player1").set_pos(Player1_pos)

	#move Player2 pad
	var Player2_pos = get_node("Player2").get_pos()

	if (Player2_pos.y > 0 and Input.is_action_pressed("player2_move_up")):
		Player2_pos.y+=-PAD_SPEED*delta
	if (Player2_pos.y < screen_size.y and Input.is_action_pressed("player2_move_down")):
		Player2_pos.y+=PAD_SPEED*delta

	get_node("Player2").set_pos(Player2_pos)


