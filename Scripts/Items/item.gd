extends Area2D

@export var default_texture: Texture2D
@export var clicked_texture: Texture2D
@export var change_duration: float = 1.0  # Duration in seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize the sprite texture
	$Sprite2D.texture = default_texture

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		_change_sprite()

func _change_sprite():
	# Change to the clicked texture
	$Sprite2D.texture = clicked_texture
	# Start a timer to revert the sprite
	var timer = Timer.new()
	timer.wait_time = change_duration
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_reset_sprite"))
	add_child(timer)
	timer.start()

func _reset_sprite():
	# Revert to the default texture
	$Sprite2D.texture = default_texture
