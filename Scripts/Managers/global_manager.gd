extends Node2D

# Stack to store previous scenes
var scene_stack: Array = []
# Dictionary to store collected items by their type
var collected_items: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	update_items_based_on_global_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# This method will be used to transition between scenes
func transition_to_scene(scene_path: String) -> void:
	var scene = load(scene_path) as PackedScene
	if scene:
		# Correctly instantiate and set the new scene
		var tree = get_tree()
		var new_scene_instance = scene.instantiate()
		tree.root.add_child(new_scene_instance)  # Add the new scene to the root
		tree.current_scene.queue_free()  # Optionally free the old scene
		tree.current_scene = new_scene_instance  # Set the new scene as the current scene
	else:
		print("Scene not found: %s" % scene_path)

func update_items_based_on_global_state():
	for item in get_tree().get_nodes_in_group("items"):
		if item is Area2D and GlobalManager.collected_items.has(item.item_type):
			item.queue_free()
