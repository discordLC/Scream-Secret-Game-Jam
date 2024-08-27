# res://Scripts/Items/clickable_item.gd
extends Area2D

# Reference the enum from the global script
const ItemType = GlobalManager.ItemType

var click_messages = {
	ItemType.KEYS: "You clicked on the keys!",
	ItemType.WRENCH: "You clicked on the wrench!"
}

@onready var sprite: Sprite2D = $Sprite2D

@export var item_type: ItemType
@export var click_message: String

func _ready():
	match item_type:
		ItemType.KEYS:
			sprite.texture = preload("res://icon.svg")
		ItemType.WRENCH:
			sprite.texture = preload("res://icon.svg")
	
	click_message = click_messages.get(item_type, "Unknown item")
	
	if GlobalManager.collected_items.has(item_type):
		queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not GlobalManager.collected_items.has(item_type):
			GlobalManager.add_item_to_inventory(item_type)  # Add item to inventory
			print(click_message)
		queue_free()
