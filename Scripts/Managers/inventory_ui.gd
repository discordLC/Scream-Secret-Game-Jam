extends Control

const NUM_SLOTS = 5
var slots: Array = []
var selected_item: int = -1  # -1 represents no selection

@onready var click_sound_player = $AudioStreamPlayer2D  # Adjust the path according to your scene setup
@onready var hover_material: ShaderMaterial = preload("res://Materials/Shader/outline.tres")  # Path to your shader material

func _ready():
	# Initialize inventory slots
	for i in range(NUM_SLOTS):
		var slot = $InventorySlots.get_node("Slot" + str(i + 1)) as TextureButton
		if slot:
			slots.append(slot)
			slot.texture_normal = load("res://Sprites/empty slot texture.png")  # Changed to load()
			slot.connect("pressed", Callable(self, "_on_slot_pressed").bind(i))
			# Connect mouse enter and exit signals
			slot.connect("mouse_entered", Callable(self, "_on_slot_mouse_entered").bind(slot))
			slot.connect("mouse_exited", Callable(self, "_on_slot_mouse_exited").bind(slot))
		else:
			print("Slot not found: Slot" + str(i + 1))

func update_inventory(items: Dictionary) -> void:
	for i in range(NUM_SLOTS):
		if i < items.size():
			var _item = items.keys()[i]
			var icon_path = "res://Sprites/Icons/icon." + str(_item) + ".png"
			slots[i].texture_normal = load(icon_path)  # Changed to load()
		else:
			if i < slots.size():
				slots[i].texture_normal = load("res://Sprites/empty slot texture.png")  # Changed to load()

func _on_slot_pressed(slot_index: int):
	if slot_index < GlobalManager.collected_items.size():
		if selected_item == -1:
			selected_item = GlobalManager.collected_items.keys()[slot_index]
			print("Selected item: %s" % selected_item)
			# Play click sound
			click_sound_player.play()
		else:
			if GlobalManager.current_interactable:
				var success = GlobalManager.use_item_on_interactable(selected_item)
				print("Interaction success: %s" % success)
				if success:
					selected_item = -1
				else:
					print("Item cannot be used here")
			else:
				print("No interactable selected")
				selected_item = -1

func _on_slot_mouse_entered(slot: TextureButton):
	slot.material = hover_material

func _on_slot_mouse_exited(slot: TextureButton):
	slot.material = null
