extends Control
class_name MainMenu

@onready var add_button_margin: MarginContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AddButtonMargin
@onready var add_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AddButtonMargin/AddButton

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

var TRACKER = preload("res://UI/tracker.tscn")

# roll buttons
@onready var roll: Button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Roll
@onready var dice_amount: SpinBox = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/DiceAmount
@onready var dice_type: Button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/dice_type
@onready var result: Button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/result

@onready var menu_button: MenuButton = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/PanelContainer/MenuButton

# edit
@onready var edit_default_panel: EditPanel = $EditDefaultPanel
@onready var load_panel: LoadPanel = $LoadPanel
@onready var save_panel: SavePanel = $SavePanel
@onready var info_panel: PanelContainer = $InfoPanel

const TEXT_THEME = preload("res://themes/text.tres")

func _ready():
	Global.saver_loader.load_settings()
	
	menu_button.get_popup().id_pressed.connect(on_menu_item_selected)
	update_font_size(0)
	
	add_tracker(Global.save_file_default_ti)

func on_menu_item_selected(id: int) -> void:
	var popup = menu_button.get_popup()
	popup.get_item_text(id)

	match id:
		0:# show dice
			roll.visible = !roll.visible
			dice_amount.visible = !dice_amount.visible
			dice_type.visible = !dice_type.visible
			result.visible = !result.visible
			
			var item_text : String = popup.get_item_text(id)
			if item_text == "⚃ Show dice":
				popup.set_item_text(id, "⚃ Hide dice")
			else:
				popup.set_item_text(id, "⚃ Show dice")
		1:# increase font size
			update_font_size(10)
		2:# decrease font size
			update_font_size(-10)
		3:# delete trackers
			_delete_all_trackers()
		4:# save
			save_panel.visible = true
		5:# load
			load_panel.visible = true
			load_panel.load_files()
		6:# edit
			edit_default_panel.visible = true
			edit_default_panel.set_values(Global.current_default_tracker)
		7:# info
			info_panel.visible = true
		_:
			pass

func add_tracker(tracker_info : TrackerInfo) -> void:
	var new_tracker : Tracker = tracker_info.get_tracker()
	v_box_container.add_child(new_tracker)
	new_tracker.update_font_size(Global.current_UI_size)
	
	if tracker_info.is_minimized:
		new_tracker._on_minimize_pressed()
	if tracker_info.is_show_note:
		new_tracker._on_notes_button_pressed()
	
	add_button_margin.reparent(self)
	add_button_margin.reparent(v_box_container)

func update_font_size(amount : int):
	Global.current_UI_size += amount
	TEXT_THEME.set_font_size("font_size", "Button",  Global.current_UI_size)
	
	menu_button.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	var menu_items : PopupMenu = menu_button.get_popup()
	menu_items.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	for track in v_box_container.get_children():
		if track is Tracker:
			track.update_font_size(Global.current_UI_size)
	
	# for spinbox we edit the internal linedit
	var dice_line_edit : LineEdit = dice_amount.get_line_edit()
	dice_line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	# update edit screen
	edit_default_panel.update_color_size()
	
	# save menu
	save_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	save_panel.actual_save_name.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.space.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	
	# load menu
	load_panel.load_title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	load_panel.presets_title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	
	# edit default
	edit_default_panel.default_title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	edit_default_panel.tracker_name.add_theme_font_size_override("font_size", Global.current_UI_size)
	edit_default_panel.tracker_value.add_theme_font_size_override("font_size", Global.current_UI_size)
	edit_default_panel.notes.add_theme_font_size_override("font_size", Global.current_UI_size)
	# For SpinBox we target the internal LineEdit:
	var line_edit : LineEdit = edit_default_panel.m_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit = edit_default_panel.m_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit = edit_default_panel.p_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit = edit_default_panel.p_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	# info menu
	info_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	info_panel.content.add_theme_font_size_override("normal_font_size", Global.current_UI_size)

func _delete_all_trackers() -> void:
	for item in v_box_container.get_children():
		if item is Tracker:
			item.queue_free()

func _on_add_button_pressed() -> void:
	var tracker : Tracker = TRACKER.instantiate()
	
	v_box_container.add_child(tracker)
	tracker.update_font_size(Global.current_UI_size)
	
	add_button_margin.reparent(self)
	add_button_margin.reparent(v_box_container)

func _on_roll_pressed() -> void:
	var dice_res : int = 0
	match dice_type.text:
		"  D2  ":
			for i in dice_amount.value:
				dice_res += randi_range(0, 1)
		"  D4  ":
			for i in dice_amount.value:
				dice_res += randi_range(1, 4)
		"  D6  ":
			for i in dice_amount.value:
				dice_res += randi_range(1, 6)
		"  D10  ":
			for i in dice_amount.value:
				dice_res += randi_range(0, 9)
		"  D12  ":
			for i in dice_amount.value:
				dice_res += randi_range(1, 12)
		"  D20  ":
			for i in dice_amount.value:
				dice_res += randi_range(1, 20)
		_:
			dice_type.text = ""
	
	result.text = str(dice_res)

func _on_dice_type_pressed() -> void:
	match dice_type.text:
		"  D2  ":
			dice_type.text = "  D4  "
		"  D4  ":
			dice_type.text = "  D6  "
		"  D6  ":
			dice_type.text = "  D10  "
		"  D10  ":
			dice_type.text = "  D12  "
		"  D12  ":
			dice_type.text = "  D20  "
		"  D20  ":
			dice_type.text = "  D2  "
		_:
			dice_type.text = "  D2  "

func _on_result_pressed() -> void:
	result.text = ""
