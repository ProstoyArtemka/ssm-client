extends Node

@export
var scene: PackedScene
var currentLevel = null

var settings = {
	"WindowHeight": 720,
	"WindowWidth": 1280,
	
	"Host": "127.0.0.1",
	"Port": 2000
}

func _ready() -> void:
	Globals.root = self
	
	currentLevel = scene.instantiate()
	
	add_child(currentLevel)
