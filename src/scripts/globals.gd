extends Node

var block_id: int = 0

func get_block_id() -> int:
	block_id += 1
	return block_id
