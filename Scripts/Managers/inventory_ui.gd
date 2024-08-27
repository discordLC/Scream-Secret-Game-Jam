# res://Scripts/Managers/inventory_ui.gd
extends Control

const NUM_SLOTS = 5
var slots: Array = []
var selected_item: int = -1  # -1 represents no selection

@onready var ItemType = GlobalManager.ItemType

func _ready():
	# Initialize inventory slots
	for i in range(NUM_SLOTS):
		var slot = $InventorySlots.get_node("Slot" + str(i + 1)) as TextureButton
		if slot:
			slots.append(slot)
			slot.texture_normal = preload("res://Sprites/empty slot texture.png")
			slot.connect("pressed", Callable(self, "_on_slot_pressed").bind(i))
		else:
			print("Slot not found: Slot" + str(i + 1))

func update_inventory(items: Dictionary) -> void:
	for i in range(NUM_SLOTS):
		if i < items.size():
			var item = items.keys()[i]
			slots[i].texture_normal = preload("res://icon.svg")  # Update with the item icon
		else:
			if i < slots.size():
				slots[i].texture_normal = preload("res://Sprites/empty slot texture.png")

func _on_slot_pressed(slot_index: int):
	if slot_index < GlobalManager.collected_items.size():
		if selected_item == -1:
			selected_item = GlobalManager.collected_items.keys()[slot_index]
			print("Selected item: %s" % selected_item)
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
