extends "res://src/scripts/tetriminos/base.gd"

# disable rotation for O block
func try_rotate(degree):
	pass

func _ready():
	set_color(Color("#FFFF00"))