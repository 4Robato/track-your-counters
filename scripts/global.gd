extends Node

const PATH_SAVE_DIRECTORY : String = "user://Saves/"
const PATH_SETTINGS : String = "user://"

# DEFAULT VALUES:
var DEFAULT_UI_SIZE : int = 45
var DEFAULT_TRACKER_INFO : TrackerInfo = TrackerInfo.new()

var load_tracker : TrackerInfo = TrackerInfo.new()
var load_UI_size : int = 45

@onready var saver_loader : SaverLoader = SaverLoader.new()
var main_menu : MainMenu

enum BUTTON_TYPE {
	PLUS,
	MINUS,
	MULTIPLY,
	DIVIDE
}

enum COLORS {
	BLACK,
	WHITE,
	YELLOW,
	RED,
	BLUE,
	CYAN,
	GREEN,
	BROWN,
	ORANGE
}

# Values in the save file
var save_file_default_ti : TrackerInfo = TrackerInfo.new()
var save_file_UI_size : int = 45

# Current defaults:
var current_default_tracker : TrackerInfo = TrackerInfo.new()

var current_UI_size : int

func _ready() -> void:
	current_UI_size = save_file_UI_size
	current_default_tracker = save_file_default_ti
	
	for node in self.get_parent().get_children():
		print("node", node)
		if node is MainMenu:
			main_menu = node

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
