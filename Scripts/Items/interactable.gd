# res://Scripts/Items/interactable.gd
extends Area2D

signal unlocked

var is_locked = true

func unlock():
	if is_locked:
		is_locked = false
		emit_signal("unlocked")
		print("Interactable object unlocked!")
		queue_free()  # Optionally remove the object
