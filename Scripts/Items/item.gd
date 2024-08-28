# res://Scripts/Items/item.gd
extends Area2D

@export var default_texture: Texture2D
@export var clicked_texture: Texture2D

@onready var timer: Timer = $SpriteChangeTimer

var is_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = default_texture
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_reset_sprite"))

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed and not is_clicked:
		_change_sprite()

func _change_sprite():
	$Sprite2D.texture = clicked_texture
	is_clicked = true
	timer.start()

func _reset_sprite():
	$Sprite2D.texture = default_texture
	is_clicked = false
