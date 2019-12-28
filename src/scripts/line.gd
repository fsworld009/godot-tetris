extends Node2D

var blocks: int = 0

func _on_grid_body_entered(body):
	print(body.get_parent().name)
	blocks += 1
	print(name, " ", blocks)


func _on_grid_body_exited(body):
	blocks -= 1
	print(name, blocks)


func _on_Line_area_entered(area):
	print('work')
