extends Area2D

@export var target_scene: PackedScene

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("New Room")
		if target_scene:
			get_tree().change_scene_to_packed(target_scene)
		else:
			print("Error: target_scene is not assigned.")
