extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var PRESSED_REACTION_DELTA: float = 12
var PRESSED_CONTINUE_DELTA: float = 2

var remain_blocks = 4
var drop_wait: float = 1024
var accu_delta: float = 0
var controlling_tetrimino = true
var pressed_delta: float = PRESSED_REACTION_DELTA


func move(action: String, rel_vec: Vector2) -> KinematicCollision2D:
	if Input.is_action_just_pressed(action):
			pressed_delta = PRESSED_REACTION_DELTA
			return move_and_collide(rel_vec)
	elif Input.is_action_pressed(action):
		pressed_delta -= 1
		if (pressed_delta <= 0):
			pressed_delta = PRESSED_CONTINUE_DELTA
			return move_and_collide(rel_vec)
	return null

func _physics_process(delta):
	#print(get_transform())
	
	if controlling_tetrimino:
		accu_delta += (delta * 1000)
		var collision: KinematicCollision2D = null
		# rotate
		if (Input.is_action_just_pressed("rotate_right")
			and !test_move(Transform2D(deg2rad(90), position), Vector2(0,0))):
			rotate(deg2rad(90))
		if (Input.is_action_just_pressed("rotate_left")
			and !test_move(Transform2D(deg2rad(-90), position), Vector2(0,0))):
			rotate(deg2rad(-90))

		# movement
		move("move_left", Vector2(-16, 0))
		move("move_right", Vector2(16, 0))
		move("move_down", Vector2(0, 16))
		
		# move down automatically
		if accu_delta >= drop_wait:
			accu_delta = 0
			# Don't move down again when pressing down
			if !Input.is_action_pressed("move_down"):
				collision = move_and_collide(Vector2(0, 16))
				if collision:
					controlling_tetrimino = false
			# instead check if ground is hit
			elif test_move(Transform2D(0, position), Vector2(0, 1)):
				controlling_tetrimino = false

func set_color(color: Color):
	for block in get_children():
		(block as Block).set_color(color)
