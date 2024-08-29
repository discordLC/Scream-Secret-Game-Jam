# res://Scripts/Managers/dialogue_ui.gd
extends Control

@onready var text_label: Label = $Label
@onready var close_button: Button = $Button

func _ready():
	hide()  # Hide initially

func show_dialogue(text: String) -> void:
	if text_label:  # Ensure text_label is not null
		text_label.text = text
		self.visible = true
	else:
		print("Error: text_label is null")

func _on_button_pressed() -> void:
	hide()
