extends Sprite2D

@export var sprite_textures: Array[Texture2D] = []

# Called when the node enters the scene tree for the first time
func _ready():
	_change_sprite()

func _change_sprite():
	if sprite_textures.size() > 0:
		var random_index = randi() % sprite_textures.size()
		texture = sprite_textures[random_index]
