extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var PRESSED_REACTION_DELTA: float = 12
var PRESSED_CONTINUE_DELTA: float = 2

var remain_blocks = 4
var drop_wait: float = 1024
var accu_delta: float = 0
var controlling_tetrimino = true
var pressed_delta: float = PRESSED_REACTION_DELTA

signal on_drop

# return true if moves successfully
func try_move(rel_vec: Vector2) -> bool:
	var collision: KinematicCollision2D = null
	var curr_position: Vector2 = position
	collision = move_and_collide(rel_vec)
	# Prevent movement if collide
	if collision:
		position = curr_position
		return false
	return true


func move_by_player(action: String, rel_vec: Vector2):
	if Input.is_action_just_pressed(action):
			pressed_delta = PRESSED_REACTION_DELTA
			try_move(rel_vec)
	elif Input.is_action_pressed(action):
		pressed_delta -= 1
		if (pressed_delta <= 0):
			pressed_delta = PRESSED_CONTINUE_DELTA
			try_move(rel_vec)


func try_rotate(degree: float):
	var curr_position = get_position()
	var curr_rotation = get_rotation()
	rotate(deg2rad(degree))
	move_and_collide(Vector2(0, 0))
	if position != curr_position:
		# revert rotation if collide happens
		set_position(curr_position)
		set_rotation(curr_rotation)

func _physics_process(delta):
	if controlling_tetrimino:
		accu_delta += (delta * 1000)
		var collision: KinematicCollision2D = null
		# rotate
		if (Input.is_action_just_pressed("rotate_right")):
			try_rotate(90)
		elif (Input.is_action_just_pressed("rotate_left")):
			try_rotate(-90)

		# movement
		move_by_player("move_left", Vector2(-16, 0))
		move_by_player("move_right", Vector2(16, 0))
		move_by_player("move_down", Vector2(0, 16))
		
		# move down automatically
		if accu_delta >= drop_wait:
			accu_delta = 0
			if !Input.is_action_pressed("move_down"):
				#position.y += 16.0
				if !try_move(Vector2(0, 16)):
					controlling_tetrimino = false
					emit_signal("on_drop")
			# Don't move down again when pressing down
			# instead check if ground is hit
			elif test_move(Transform2D(0, position), Vector2(0, 5)):
				controlling_tetrimino = false
				emit_signal("on_drop")

func set_color(color: Color):
	for block in get_children():
		(block as Block).set_color(color)
