extends PanelContainer
class_name LoadPanel

var trackers : Array[TrackerInfo]
@onready var main_menu : MainMenu = get_parent()
const LOAD_BUTTON = preload("res://UI/load_button.tscn")

@onready var load_container: VBoxContainer = $MarginContainer/VBoxContainer/PanelContainer/ScrollContainer/LoadContainer
const TEXT = preload("res://themes/text.tres")

@onready var load_title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/LoadTitle
@onready var presets_title: RichTextLabel = $MarginContainer/VBoxContainer/PresetsTitle

func load_files() -> void:
	var saves_names : Array[String] = []
	
	for node in load_container.get_children():
		if node is LoadButton:
			node.queue_free()
	
	var dir := DirAccess.open(Global.PATH_SAVE_DIRECTORY)
	if dir == null:
		printerr("Could not open folder")
		return
	
	var files = dir.get_files()
	for file in files:
		if file.ends_with(".save"):
			saves_names.append(file)
	
	for file in saves_names:
		var load_button : LoadButton = LOAD_BUTTON.instantiate()
		load_container.add_child(load_button)
		load_button.load_button.text = file

func _on_close_button_pressed() -> void:
	self.visible = false

# PRESETS:
func _add_preset(default : TrackerInfo, all_info : Array[TrackerInfo]) -> void:
	Global.default_tracker = default
	main_menu.on_menu_item_selected(3)
	for track : TrackerInfo in all_info:
		main_menu.add_tracker(track)

func _on_preset_pressed() -> void:
	_on_close_button_pressed()
	
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Player 1",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Player 2",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_3 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Player 3",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_4 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Player 4",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Player ",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2, t_info_3, t_info_4])

func _on_preset_2_pressed() -> void:
	_on_close_button_pressed()
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Life",
		20,
		Global.COLORS.RED,
		""
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"Poison",
		0,
		Global.COLORS.GREEN,
		"When you get 10 or more poison tokens you lose.\nYou are considered poisoned if you have at least a poison token and corrupt if you have three or more."
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		3,
		Global.BUTTON_TYPE.MINUS,
		5,
		Global.BUTTON_TYPE.MINUS,
		"Planeswalker",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2])


func _on_preset_3_pressed() -> void:
	_on_close_button_pressed()
	
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.MINUS,
		3,
		Global.BUTTON_TYPE.MINUS,
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		"Player Name (HP)",
		0,
		Global.COLORS.RED,
		">Class:___ \n>race: ___ >alignment: ___ >deity: ___ \n>weight: ___ >eyes: ___ >skin: ___ \nSize: ___ >Age: ___ >Gender: ___ >height:\n"
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"AC",
		0,
		Global.COLORS.WHITE,
		""
	)
	var t_info_3 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"INITIATIVE",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_4 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"TOUCH",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_5 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"FLAT-FOOTED",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_6 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"STR",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_7 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"DEX",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_8 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"CON",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_9 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"INT",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_10 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"WIS",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_11 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"CHA",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_12 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"FORTITUDE",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_13 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"REFLEX",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_14 : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"WILL",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		Global.BUTTON_TYPE.PLUS,
		3,
		Global.BUTTON_TYPE.PLUS,
		5,
		Global.BUTTON_TYPE.PLUS,
		1,
		Global.BUTTON_TYPE.MINUS,
		"",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2, t_info_3, t_info_4,
		t_info_5, t_info_6, t_info_7, t_info_8, t_info_9, t_info_10, t_info_11,
		t_info_12, t_info_13, t_info_14])


func _on_preset_4_pressed() -> void:
	_on_close_button_pressed()
	
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		10,
		Global.BUTTON_TYPE.MINUS,
		30,
		Global.BUTTON_TYPE.MINUS,
		50,
		Global.BUTTON_TYPE.MINUS,
		10,
		Global.BUTTON_TYPE.PLUS,
		"Pokemon 1",
		0,
		Global.COLORS.BLACK,
		"Current mana attached: \nStatus: "
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		10,
		Global.BUTTON_TYPE.MINUS,
		30,
		Global.BUTTON_TYPE.MINUS,
		50,
		Global.BUTTON_TYPE.MINUS,
		10,
		Global.BUTTON_TYPE.PLUS,
		"Pokemon ",
		0,
		Global.COLORS.BLACK,
		"Current mana attached: \nStatus: "
	)
	
	_add_preset(t_info_default, [t_info_1])
