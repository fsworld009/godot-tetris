extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var blocks: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	blocks = ($Blocks as Node2D).get_children()
	# move Collision2D nodes from each child Block to this tetrimino
	# to get the collision area of this tetrimino shape
	for block in blocks:
		var collision_node: CollisionPolygon2D = block.get_node("CollisionPolygon2D")
		block.remove_child(collision_node)
		add_child(collision_node)

func set_color(color: Color):
	for block in blocks:
		(block as Block).set_color(color)
