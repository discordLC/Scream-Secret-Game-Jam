# res://Scripts/Items/door.gd
extends Area2D

@export var target_scene: String = ""

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if target_scene != "":
			GlobalManager.transition_to_scene(target_scene)
		else:
			print("Target scene path is not set")
