extends Node2D

const Tetrimino = preload('res://src/scripts/tetriminos/base.gd')
const Block = preload('res://src/scripts/block.gd')
var blocks = {}

func _on_grid_body_shape_entered(body_id, body: Tetrimino, body_shape: int, area_shape):
	var block: Block = body.get_child(body_shape)
	blocks[block.id] = block


func _on_grid_body_shape_exited(body_id, body: Tetrimino, body_shape: int, area_shape):
	var block: Block = body.get_child(body_shape)
	blocks.erase(block.id)
