# res://Scripts/Items/unlocked_item.gd
extends Area2D

# Scene path to preload (define here directly in the code)
var scene_path: String = "res://Scenes/World/Rooms/room_2.tscn"

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if scene_path != "":
			GlobalManager.transition_to_scene(scene_path)
		else:
			print("Target scene path is not set")
