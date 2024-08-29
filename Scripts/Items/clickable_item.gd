# res://Scripts/Items/clickable_item.gd
extends Area2D

const ItemType = GlobalManager.ItemType

var click_messages = {
	ItemType.KEYS: "You clicked on the keys!",
	ItemType.WRENCH: "You clicked on the wrench!"
}

@onready var sprite: Sprite2D = $Sprite2D
@onready var hover_material: ShaderMaterial = preload("res://Materials/Shader/outline.tres")

@export var item_type: ItemType
@export var click_message: String

func _ready():
	match item_type:
		ItemType.KEYS:
			sprite.texture = preload("res://Sprites/Icons/icon.0.png")
		ItemType.WRENCH:
			sprite.texture = preload("res://Sprites/Icons/icon.1.png")
	
	click_message = click_messages.get(item_type, "Unknown item")
	
	if GlobalManager.collected_items.has(item_type) or GlobalManager.used_items.has(item_type):
		queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not GlobalManager.collected_items.has(item_type) and not GlobalManager.used_items.has(item_type):
			GlobalManager.add_item_to_inventory(item_type)
			print(click_message)
		queue_free()

func _on_mouse_entered():
	sprite.material = hover_material

func _on_mouse_exited():
	sprite.material = null
