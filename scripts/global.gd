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

@warning_ignore("unused_signal")
signal load_file_request(file_name : String)

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

func get_scaled_icon(icon: Texture2D, _size: int) -> Texture2D:
	if icon == null:
		return null
	var img = icon.get_image()
	img.resize(_size, _size, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(img)

func compare_trackers(info_tracker_1 : TrackerInfo, info_tracker_2 : TrackerInfo) -> bool:
	if info_tracker_1.button_m1 != info_tracker_2.button_m1:
		return false
	if info_tracker_1.button_m1_type != info_tracker_2.button_m1_type:
		return false
	if info_tracker_1.button_m2 != info_tracker_2.button_m2:
		return false
	if info_tracker_1.button_m2_type != info_tracker_2.button_m2_type:
		return false
	if info_tracker_1.button_p1 != info_tracker_2.button_p1:
		return false
	if info_tracker_1.button_p1_type != info_tracker_2.button_p1_type:
		return false
	if info_tracker_1.button_p2 != info_tracker_2.button_p2:
		return false
	if info_tracker_1.button_p2_type != info_tracker_2.button_p2_type:
		return false
	
	if info_tracker_1.tracker_name != info_tracker_2.tracker_name:
		return false
	if info_tracker_1.tracker_notes != info_tracker_2.tracker_notes:
		return false
	if info_tracker_1.tracker_color != info_tracker_2.tracker_color:
		return false
	if info_tracker_1.tracker_value != info_tracker_2.tracker_value:
		return false
	
	return true
