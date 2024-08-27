# res://Scripts/Objects/interactable.gd
extends Area2D

# The item type required to interact with this object
@export var required_item_type: int = -1  # Default value indicating no item required
var unlocked: bool = false

@onready var ItemType = GlobalManager.ItemType

func _ready():
	print("Interactable ready: %s" % self.name)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalManager.set_current_interactable(self)
		print("Interactable selected: %s" % self.name)

func use_item(item_type: int) -> bool:
	if required_item_type == item_type:
		unlocked = true
		$Sprite2D.texture = preload("res://icon.svg")  # Change texture to indicate unlocked state
		print("Object unlocked with item: %s" % item_type)
		return true
	else:
		print("Item %s is not the right item" % item_type)
		return false
