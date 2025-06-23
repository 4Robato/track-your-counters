extends Node

enum BUTTON_TYPE {
	PLUS,
	MINUS,
	MULTIPLY,
	DIVIDE
}

# Current defaults:
var default_tracker : TrackerInfo = TrackerInfo.new()
var saved_UI_size : int = 45

var current_UI_size : int

func _ready() -> void:
	Global.current_UI_size = saved_UI_size

func _get_button_type(button : Button) -> Global.BUTTON_TYPE:
	match button.text:
		"  -  ":
			return Global.BUTTON_TYPE.MINUS
		"  +  ":
			return Global.BUTTON_TYPE.PLUS
		"  x  ":
			return Global.BUTTON_TYPE.MULTIPLY
		"  ÷  ":
			return Global.BUTTON_TYPE.DIVIDE
		_:
			return Global.BUTTON_TYPE.PLUS

func _get_button_text(type : Global.BUTTON_TYPE) -> String:
	match type:
		Global.BUTTON_TYPE.PLUS:
			return "  +  "
		Global.BUTTON_TYPE.MINUS:
			return "  -  "
		Global.BUTTON_TYPE.MULTIPLY:
			return "  x  "
		Global.BUTTON_TYPE.DIVIDE:
			return "  ÷  "
		_:
			return "  ?  "

func get_scaled_icon(icon: Texture2D, _size: int) -> Texture2D:
	if icon == null:
		return null
	var img = icon.get_image()
	img.resize(_size, _size, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(img)
