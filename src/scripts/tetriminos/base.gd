extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var PRESSED_REACTION_DELTA: float = 12
var PRESSED_CONTINUE_DELTA: float = 2

var remain_blocks = 4
var drop_wait: float = 256
var accu_delta: float = 0
var controlling_tetrimino = true
var pressed_delta: float = PRESSED_REACTION_DELTA

func _physics_process(delta):
	if controlling_tetrimino:
		accu_delta += (delta * 1000)
		var collision: KinematicCollision2D = null
		if Input.is_action_just_pressed("move_right"):
			pressed_delta = PRESSED_REACTION_DELTA
			collision = move_and_collide(Vector2(16, 0))
		elif Input.is_action_pressed("move_right"):
			pressed_delta -= 1
			if (pressed_delta <= 0):
				pressed_delta = PRESSED_CONTINUE_DELTA
				collision = move_and_collide(Vector2(16, 0))
		if Input.is_action_just_pressed("move_left"):
			pressed_delta = PRESSED_REACTION_DELTA
			collision = move_and_collide(Vector2(-16, 0))
		elif Input.is_action_pressed("move_left"):
			pressed_delta -= 1
			if (pressed_delta <= 0):
				pressed_delta = PRESSED_CONTINUE_DELTA
				collision = move_and_collide(Vector2(-16, 0))
		if accu_delta >= drop_wait:
			collision = move_and_collide(Vector2(0, 16))
			accu_delta = 0
			if collision:
				controlling_tetrimino = false
		#print("Hit ground")
	
	

func set_color(color: Color):
	for block in get_children():
		(block as Block).set_color(color)
