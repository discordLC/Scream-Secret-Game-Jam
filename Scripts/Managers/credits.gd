extends Control

func _on_button_pressed():
	# Load the bedroom scene
	get_tree().change_scene_to_file("res://Scenes/World/main_menu.tscn")
