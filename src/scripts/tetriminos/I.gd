extends "res://src/scripts/tetriminos/base.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_color(Color("#FF0000"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var drop_wait: float = 16
var accu_delta: float = 0

func _physics_process(delta):
	accu_delta += (delta * 1000)
	if Input.is_action_just_pressed("move_right"):
		move_and_collide(Vector2(16, 0))
	if Input.is_action_just_pressed("move_left"):
		move_and_collide(Vector2(-16, 0))
	if accu_delta >= drop_wait:
		move_and_collide(Vector2(0, 16))
		accu_delta = 0