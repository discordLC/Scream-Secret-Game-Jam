# res://Scripts/Objects/interactable.gd
extends Area2D

# The item type required to interact with this object
@export var required_item_type: int = -1
@export var open_door_scene_path: String = ""  # Path to the open door scene
var unlocked: bool = false

@onready var sprite: Sprite2D = $Sprite2D

# Define individual sprites for each item type
var sprite_for_keys: Texture2D = preload("res://icon.svg")  # Example path for keys
var sprite_for_wrench: Texture2D = preload("res://Sprites/Placeholder/Picture.png")  # Example path for wrench

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
		if open_door_scene_path != "":
			change_to_open_door_scene()
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

func change_to_open_door_scene() -> void:
	if open_door_scene_path != "":
		var open_door_scene = load(open_door_scene_path) as PackedScene
		if open_door_scene:
			var new_scene_instance = open_door_scene.instantiate()
			if new_scene_instance:
				new_scene_instance.position = self.position
				new_scene_instance.rotation = self.rotation
				self.get_parent().add_child(new_scene_instance)
				self.queue_free()
		else:
			print("Open door scene not found: %s" % open_door_scene_path)
	else:
		print("Open door scene path is not set")
		
