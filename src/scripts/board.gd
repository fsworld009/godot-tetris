extends Node2D

const Tetrimino = preload('res://src/scripts/tetriminos/base.gd')

var TetriminoScenes = [
	load("res://src/scenes/tetriminos/I.tscn"),
	load("res://src/scenes/tetriminos/J.tscn"),
	load("res://src/scenes/tetriminos/L.tscn"),
	load("res://src/scenes/tetriminos/O.tscn"),
	load("res://src/scenes/tetriminos/S.tscn"),
	load("res://src/scenes/tetriminos/T.tscn"),
	load("res://src/scenes/tetriminos/Z.tscn"),
]
var rotation_index = 0

func _ready():
	start_game()
	
func on_tetrimino_drop():
	add_tetrimino()

func start_game():
	randomize()
	TetriminoScenes.shuffle()
	add_tetrimino()
	

func add_tetrimino():
	var tetrimino: Tetrimino = TetriminoScenes[rotation_index].instance()
	tetrimino.connect("on_drop", self, "on_tetrimino_drop")
	$Tetriminos.add_child(tetrimino)
	tetrimino.set_position(Vector2(88, 24))
	rotation_index += 1
	if rotation_index == 7:
		TetriminoScenes.shuffle()
		rotation_index = 0
