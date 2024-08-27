# res://Scripts/Managers/global_manager.gd
extends Node2D

var collected_items: Dictionary = {}
var current_interactable: Area2D = null

@onready var inventory_ui = InventoryUi  # Accessing the autoloaded InventoryUI
const MAX_INVENTORY_SIZE = 5

enum ItemType {
	KEYS,
	WRENCH
}

func _ready():
	update_items_based_on_global_state()
	if inventory_ui:
		update_inventory_ui()

func update_items_based_on_global_state():
	for item in get_tree().get_nodes_in_group("items"):
		if item is Area2D and collected_items.has(item.item_type):
			item.queue_free()
	update_inventory_ui()

func update_inventory_ui() -> void:
	if inventory_ui:
		inventory_ui.update_inventory(collected_items)

func add_item_to_inventory(item_type: int) -> void:
	if collected_items.size() < MAX_INVENTORY_SIZE:
		collected_items[item_type] = true
		update_inventory_ui()
	else:
		print("Inventory is full")

func remove_item_from_inventory(item_type: int) -> void:
	if collected_items.has(item_type):
		collected_items.erase(item_type)
		update_inventory_ui()

func set_current_interactable(interactable: Area2D) -> void:
	current_interactable = interactable
	print("Current interactable set to: %s" % current_interactable.name)

func use_item_on_interactable(item_type: int) -> bool:
	if current_interactable:
		var success = current_interactable.use_item(item_type)
		if success:
			remove_item_from_inventory(item_type)
		current_interactable = null
		return success
	return false


func transition_to_scene(scene_path: String) -> void:
	var scene = load(scene_path) as PackedScene
	if scene:
		var tree = get_tree()
		var new_scene_instance = scene.instantiate()
		tree.root.add_child(new_scene_instance)
		tree.current_scene.queue_free()
		tree.current_scene = new_scene_instance
	else:
		print("Scene not found: %s" % scene_path)
