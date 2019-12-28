extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var PRESSED_REACTION_DELTA: float = 12
var PRESSED_CONTINUE_DELTA: float = 2

var blocks: Array = []
var drop_wait: float = 256
var accu_delta: float = 0
var controlling_tetrimino = true
var pressed_delta: float = PRESSED_REACTION_DELTA


# Called when the node enters the scene tree for the first time.
func _ready():
	blocks = ($Blocks as Node2D).get_children()
	print(blocks)
	# move Collision2D nodes from each child Block to this tetrimino
	# to get the collision area of this tetrimino shape
	for block in blocks:
		var collision_node: CollisionPolygon2D = block.get_node("collision")
		block.remove_child(collision_node)
		add_child(collision_node)
		# node position is reset to 0,0 after move, manually set it again
		collision_node.set_position(block.position)

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
	for block in blocks:
		(block as Block).set_color(color)
