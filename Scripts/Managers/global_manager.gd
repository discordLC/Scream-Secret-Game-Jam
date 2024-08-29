# res://Scripts/Managers/global_manager.gd
extends Node2D

var collected_items: Dictionary = {}  # Inventory
var used_items: Dictionary = {}  # Track used items
var unlocked_items: Dictionary = {}  # Track unlocked items
var current_interactable: Area2D = null
var shown_dialogues: Array = []

const MAX_INVENTORY_SIZE = 5

enum ItemType {
	KEYS,
	WRENCH
}

var dialogue_options: Array = [
	"What happened?",
	"Was that always here?",
	"How do I get out of here?",
	"Something feels off",
	"What was that?"
]

var valid_rooms: Array = [
	"Living Room",
	"Upstairs Hallway",
	"Bedroom"
]

func _ready():
	randomize()
	update_items_based_on_global_state()
	if InventoryUi:
		update_inventory_ui()
	transition_to_scene(get_tree().current_scene.name)


func update_items_based_on_global_state():
	var current_scene_name = get_tree().current_scene.name
	if unlocked_items.has(current_scene_name):
		for item_data in unlocked_items[current_scene_name]:
			var unlocked_item_scene = load(item_data["scene_path"]) as PackedScene
			if unlocked_item_scene:
				var new_item_instance = unlocked_item_scene.instantiate()
				if new_item_instance:
					new_item_instance.position = item_data["position"]
					new_item_instance.rotation = item_data["rotation"]
					get_tree().current_scene.add_child(new_item_instance)
	update_inventory_ui()

func update_inventory_ui() -> void:
	if InventoryUi:
		InventoryUi.update_inventory(collected_items)

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
			used_items[item_type] = true  # Track the item as used
		current_interactable = null
		return success
	return false

func register_unlocked_item(_interactable: Area2D, scene_path: String, position: Vector2, rotation: float) -> void:
	var current_scene_name = get_tree().current_scene.name
	if not unlocked_items.has(current_scene_name):
		unlocked_items[current_scene_name] = []
	unlocked_items[current_scene_name].append({
		"scene_path": scene_path,
		"position": position,
		"rotation": rotation
	})

func show_random_dialogue() -> void:
	var current_scene_name = get_tree().current_scene.name
	print("Current scene: %s" % current_scene_name)
	
	# Check if the current scene is a valid room
	if valid_rooms.has(current_scene_name):
		print("Current scene is a valid room for dialogue.")
		
		# Create a new array to store available dialogues
		var available_dialogues = []
		
		# Fill available_dialogues with items not in shown_dialogues
		for dialogue in dialogue_options:
			if not shown_dialogues.has(dialogue):
				available_dialogues.append(dialogue)
		
		# If all dialogues have been shown, reset the list
		if available_dialogues.size() == 0:
			print("All dialogues have been shown. Resetting...")
			reset_dialogue_state()
			available_dialogues = dialogue_options  # Reset available dialogues to all options

		# Ensure there are dialogues left to show
		if available_dialogues.size() > 0:
			var random_index = randi() % available_dialogues.size()
			var selected_dialogue = available_dialogues[random_index]
			DialogueUi.show_dialogue(selected_dialogue)
			shown_dialogues.append(selected_dialogue)
		else:
			print("No more new dialogues to show")
	else:
		print("Current scene is not a valid room for dialogue.")


func reset_dialogue_state() -> void:
	shown_dialogues.clear()  # Clear shown dialogues
	print("Dialogue state reset")

func transition_to_scene(scene_path: String) -> void:
	var scene = load(scene_path) as PackedScene
	if scene:
		var tree = get_tree()
		var new_scene_instance = scene.instantiate()
		tree.root.add_child(new_scene_instance)
		tree.current_scene.queue_free()  # Free the old scene
		tree.current_scene = new_scene_instance
		update_items_based_on_global_state()
		show_random_dialogue()  # Ensure dialogue is triggered after transition
	else:
		print("Scene not found: %s" % scene_path)
