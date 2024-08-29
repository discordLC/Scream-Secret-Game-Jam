# res://Scripts/Items/back_ui.gd
extends Area2D

@export var target_scene: String = ""

@onready var hover_material: ShaderMaterial = preload("res://Materials/Shader/outline.tres")

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if target_scene != "":
			GlobalManager.transition_to_scene(target_scene)
		else:
			print("Target scene path is not set")

func _on_mouse_entered():
	$Sprite2D.material = hover_material

func _on_mouse_exited():
	$Sprite2D.material = null
