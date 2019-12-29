extends Node2D

var id = Globals.get_block_id()

func set_color(color: Color):
	$Polygon2D.set_color(color)
