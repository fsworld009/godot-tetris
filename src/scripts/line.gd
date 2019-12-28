extends Node2D

var blocks: int = 0

func _on_grid_body_entered(body):
	blocks += 1


func _on_grid_body_exited(body):
	blocks -= 1