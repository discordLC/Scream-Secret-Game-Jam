# res://Scripts/Managers/inventory_ui.gd
extends Control

const NUM_SLOTS = 5

var slots: Array = []

func _ready():
	# Ensure slots are properly initialized
	for i in range(NUM_SLOTS):
		var slot = $InventorySlots.get_node("Slot" + str(i + 1))
		if slot:
			slots.append(slot)
			slot.texture = preload("res://Sprites/empty slot texture.png")
		else:
			print("Slot not found: Slot" + str(i + 1))

func update_inventory(items: Dictionary) -> void:
	# Ensure items have valid indices before accessing
	for i in range(NUM_SLOTS):
		if i < items.size():
			var item = items.keys()[i]
			slots[i].texture = preload("res://icon.svg")
		else:
			if i < slots.size():
				slots[i].texture = preload("res://Sprites/empty slot texture.png")
