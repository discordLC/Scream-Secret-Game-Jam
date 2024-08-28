extends Area2D

var scene_path: String = "res://Scenes/World/Rooms/room_2.tscn"
@onready var hover_material: ShaderMaterial = preload("res://Materials/Shader/outline.tres")

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if scene_path != "":
			GlobalManager.transition_to_scene(scene_path)
		else:
			print("Target scene path is not set")

func _on_mouse_entered():
	$Sprite2D.material = hover_material

func _on_mouse_exited():
	$Sprite2D.material = null
