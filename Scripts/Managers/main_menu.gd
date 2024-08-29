extends Control

func _on_play_button_pressed():
	# Load the bedroom scene
	get_tree().change_scene_to_file("res://Scenes/World/Rooms/bedroom.tscn")

func _on_credits_button_pressed():
	# Load the credits scene
	get_tree().change_scene_to_file("res://Scenes/World/credits.tscn")
