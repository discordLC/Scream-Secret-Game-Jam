extends Area2D

enum ItemType {
	KEYS,
	WRENCH
}

var click_messages = {
	ItemType.KEYS: "You clicked on the keys!",
	ItemType.WRENCH: "You clicked on the wrench!"
}

@onready var sprite: Sprite2D = $Sprite2D

@export var item_type: ItemType
@export var click_message: String

func _ready():
	# Set the sprite based on the item type
	match item_type:
		ItemType.KEYS:
			sprite.texture = preload("res://icon.svg")  # Make sure to use different textures for clarity because the icon cannot live forever
		ItemType.WRENCH:
			sprite.texture = preload("res://icon.svg")
	
	# Set the click message based on the item type
	click_message = click_messages.get(item_type, "Unknown item")
	
	# Check if this item has been collected before
	if GlobalManager.collected_items.has(item_type):
		queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print(click_message)
		GlobalManager.collected_items[item_type] = true  # Mark this item as collected
		queue_free()
