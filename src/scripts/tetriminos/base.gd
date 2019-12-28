extends KinematicBody2D

const Block = preload('res://src/scripts/block.gd')
var blocks: Array = []

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

func set_color(color: Color):
	for block in blocks:
		(block as Block).set_color(color)
