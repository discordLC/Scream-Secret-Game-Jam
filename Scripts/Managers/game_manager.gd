extends Node2D

var aspect_ratio_width: int = 16
var aspect_ratio_height: int = 9
var viewport: Viewport

func _ready():
	viewport = $SubViewport
	update_aspect_ratio()

func update_aspect_ratio():
	var screen_size = get_viewport().size
	var screen_aspect = screen_size.x / screen_size.y
	var target_aspect = aspect_ratio_width / aspect_ratio_height

	if screen_aspect > target_aspect:
		# Screen is wider than the target aspect ratio
		var new_width = int(screen_size.y * target_aspect)
		viewport.size = Vector2i(new_width, int(screen_size.y))
	else:
		# Screen is taller than the target aspect ratio
		var new_height = int(screen_size.x / target_aspect)
		viewport.size = Vector2i(int(screen_size.x), new_height)
