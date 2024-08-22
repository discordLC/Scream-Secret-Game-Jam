extends Sprite2D

@export var sprite_frames : Array = []  
@onready var sprite = $"."

func _ready():
	# Ensure there are sprite frames set
	if sprite_frames.size() == 0:
		push_error("No sprite frames set!")
		return
	
	$Timer.start

func _on_timer_timeout():
	sprite.texture = sprite_frames[randi() % sprite_frames.size()]
