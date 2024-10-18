extends Control

func _ready() -> void:
	size = Vector2(
		Globals.root.settings["WindowWidth"],
		Globals.root.settings["WindowHeight"]
	)
	
	Networking.connect_to_server(Globals.root.settings["Host"], Globals.root.settings["Port"])

func _on_button_button_down() -> void:
	Networking.send_list_lobbies()
