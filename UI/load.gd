extends PanelContainer
class_name LoadPanel

var trackers : Array[TrackerInfo]
@onready var main_menu : MainMenu = get_parent()
const LOAD_BUTTON = preload("res://UI/load_button.tscn")

@onready var load_container: VBoxContainer = $MarginContainer/VBoxContainer/PanelContainer/ScrollContainer/LoadContainer
const TEXT = preload("res://themes/text.tres")

@onready var logs_panel: LogsPanel = $"../LogsPanel"

@onready var load_title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/LoadTitle
@onready var presets_title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer2/PresetsTitle

@onready var emoji_1: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Emoji1
@onready var emoji_2: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer2/Emoji2

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
	
	logs_panel._on_clean_pressed()

func _on_close_button_pressed() -> void:
	self.visible = false

# PRESETS:
func _add_preset(default : TrackerInfo, all_info : Array[TrackerInfo]) -> void:
	Global.current_default_tracker = default
	main_menu._delete_all_trackers()
	logs_panel._on_clean_pressed()
	
	for track : TrackerInfo in all_info:
		main_menu.add_tracker(track)
	self.visible = false

func _on_preset_pressed() -> void:
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		tr("PLAYER") + " 1",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		tr("PLAYER") + " 2",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_3 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		tr("PLAYER") + " 3",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_4 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		tr("PLAYER") + " 4",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		tr("PLAYER") + " ",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2, t_info_3, t_info_4])

func _on_preset_2_pressed() -> void:
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		3,
		OperatorButton.BUTTON_TYPE.MINUS,
		5,
		OperatorButton.BUTTON_TYPE.MINUS,
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		"Life",
		20,
		Global.COLORS.RED,
		""
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"Poison",
		0,
		Global.COLORS.GREEN,
		"When you get 10 or more poison tokens you lose.\nYou are considered poisoned if you have at least a poison token and corrupt if you have three or more."
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		3,
		OperatorButton.BUTTON_TYPE.MINUS,
		5,
		OperatorButton.BUTTON_TYPE.MINUS,
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		"Planeswalker",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2])


func _on_preset_3_pressed() -> void:
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		3,
		OperatorButton.BUTTON_TYPE.MINUS,
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		"Player Name (HP)",
		0,
		Global.COLORS.RED,
		">Class:___ \n>race: ___ >alignment: ___ >deity: ___ \n>weight: ___ >eyes: ___ >skin: ___ \nSize: ___ >Age: ___ >Gender: ___ >height:\n"
	)
	
	var t_info_2 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"AC",
		0,
		Global.COLORS.WHITE,
		""
	)
	var t_info_3 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"INITIATIVE",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_4 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"TOUCH",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_5 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"FLAT-FOOTED",
		0,
		Global.COLORS.BLACK,
		""
	)
	var t_info_6 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"STR",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_7 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"DEX",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_8 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"CON",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_9 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"INT",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_10 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"WIS",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_11 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"CHA",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_12 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"FORTITUDE",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_13 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"REFLEX",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	var t_info_14 : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"WILL",
		0,
		Global.COLORS.BLACK,
		"",
		true
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		1,
		OperatorButton.BUTTON_TYPE.PLUS,
		3,
		OperatorButton.BUTTON_TYPE.PLUS,
		5,
		OperatorButton.BUTTON_TYPE.PLUS,
		1,
		OperatorButton.BUTTON_TYPE.MINUS,
		"",
		0,
		Global.COLORS.BLACK,
		""
	)
	
	_add_preset(t_info_default, [t_info_1, t_info_2, t_info_3, t_info_4,
		t_info_5, t_info_6, t_info_7, t_info_8, t_info_9, t_info_10, t_info_11,
		t_info_12, t_info_13, t_info_14])


func _on_preset_4_pressed() -> void:
	var t_info_1 : TrackerInfo = TrackerInfo.new(
		10,
		OperatorButton.BUTTON_TYPE.MINUS,
		30,
		OperatorButton.BUTTON_TYPE.MINUS,
		50,
		OperatorButton.BUTTON_TYPE.MINUS,
		10,
		OperatorButton.BUTTON_TYPE.PLUS,
		"Pokemon 1",
		0,
		Global.COLORS.BLACK,
		"Current mana attached: \nStatus: "
	)
	
	var t_info_default : TrackerInfo = TrackerInfo.new(
		10,
		OperatorButton.BUTTON_TYPE.MINUS,
		30,
		OperatorButton.BUTTON_TYPE.MINUS,
		50,
		OperatorButton.BUTTON_TYPE.MINUS,
		10,
		OperatorButton.BUTTON_TYPE.PLUS,
		"Pokemon ",
		0,
		Global.COLORS.BLACK,
		"Current mana attached: \nStatus: "
	)
	
	_add_preset(t_info_default, [t_info_1])
