# res://Scripts/Items/interactable.gd
extends Area2D

@export var required_item_type: int = -1
@export var unlocked_item_scene_path: String = ""
var unlocked: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var hover_material: ShaderMaterial = preload("res://Materials/Shader/outline.tres")

var sprite_for_keys: Texture2D = preload("res://icon.svg")
var sprite_for_wrench: Texture2D = preload("res://Sprites/Placeholder/Picture.png")

var stored_position: Vector2
var stored_rotation: float

func _ready():
	print("Interactable ready: %s" % self.name)
	update_sprite_based_on_required_item()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalManager.set_current_interactable(self)
		print("Interactable selected: %s" % self.name)

func use_item(item_type: int) -> bool:
	if required_item_type == item_type:
		unlocked = true
		update_sprite(item_type)
		print("Object unlocked with item: %s" % item_type)
		if unlocked_item_scene_path != "":
			store_position_and_rotation()
			GlobalManager.register_unlocked_item(self, unlocked_item_scene_path, stored_position, stored_rotation)
			change_to_unlocked_item_scene()
		return true
	else:
		print("Item %s is not the right item" % item_type)
		return false

func update_sprite(item_type: int) -> void:
	match item_type:
		0:
			sprite.texture = sprite_for_keys
		1:
			sprite.texture = sprite_for_wrench
		_:
			print("No sprite defined for item type: %s" % item_type)

func update_sprite_based_on_required_item() -> void:
	match required_item_type:
		0:
			sprite.texture = sprite_for_keys
		1:
			sprite.texture = sprite_for_wrench
		_:
			print("No sprite defined for required item type: %s" % required_item_type)

func store_position_and_rotation() -> void:
	stored_position = self.position
	stored_rotation = self.rotation

func change_to_unlocked_item_scene() -> void:
	if unlocked_item_scene_path != "":
		var unlocked_item_scene = load(unlocked_item_scene_path) as PackedScene
		if unlocked_item_scene:
			var new_scene_instance = unlocked_item_scene.instantiate()
			if new_scene_instance:
				new_scene_instance.position = stored_position
				new_scene_instance.rotation = stored_rotation
				self.get_parent().add_child(new_scene_instance)
				self.queue_free()
		else:
			print("Open door scene not found: %s" % unlocked_item_scene_path)
	else:
		print("Open door scene path is not set")

func _on_mouse_entered():
	sprite.material = hover_material

func _on_mouse_exited():
	sprite.material = null
