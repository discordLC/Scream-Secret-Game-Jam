# res://Scripts/Objects/interactable.gd
extends Area2D

var unlockable_item: int = -1  # The item required to unlock this interactable
var unlocked: bool = false

@onready var ItemType = GlobalManager.ItemType

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalManager.set_current_interactable(self)
		print("Interactable selected: %s" % self.name)

func use_item(item_type: int) -> bool:
	if unlockable_item == item_type:
		unlocked = true
		$Sprite2D.texture = preload("res://icon.svg")
		print("Object unlocked with item: %s" % item_type)
		return true
	else:
		print("Item %s is not the right item" % item_type)
		return false
