extends Control
class_name MainMenu

@onready var add_button_margin: MarginContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AllTrackers/AddButtonMargin
@onready var add_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AllTrackers/AddButtonMargin/AddButton

@onready var all_trackers: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AllTrackers
@onready var all_dice: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/AllDice

var TRACKER = preload("res://UI/tracker.tscn")
const DICE_TRACKER = preload("uid://bf7t5evrdlojm")

@onready var menu_button: MenuButton = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/PanelContainer/MenuButton
@onready var lang_menu_button: MenuButton = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/LanguageSelector/LangMenuButton

# Menu Panels
@onready var edit_default_panel: EditPanel = $EditDefaultPanel
@onready var load_panel: LoadPanel = $LoadPanel
@onready var save_panel: SavePanel = $SavePanel
@onready var info_panel: PanelContainer = $InfoPanel
@onready var logs_panel: LogsPanel = $LogsPanel
@onready var tracker_manager_panel: PanelContainer = $TrackerManagerPanel

const TEXT_THEME = preload("res://themes/text.tres")
var list_lang : Array[String]

func _ready():
	Global.add_custom_tracker.connect(add_tracker)
	
	Global.saver_loader.load_settings()
	
	var menu_popup := menu_button.get_popup()
	if OS.get_name() in ["Android", "Web"]:
		menu_popup.remove_item(8)
	menu_popup.id_pressed.connect(on_menu_item_selected)
	
	add_tracker(Global.save_file_default_ti)
	
	# load languages:
	var lang_popup : PopupMenu = lang_menu_button.get_popup()
	var languages = TranslationServer.get_loaded_locales()
	for lang in languages:
		var lang_name : String = TranslationServer.get_language_name(lang)
		lang_popup.add_item(lang_name + " (" + lang + ")")
		list_lang.append(lang)
	lang_popup.id_pressed.connect(_on_lang_selected)
	TranslationServer.set_locale(Global.language_selected)
	
	# this has to go after adding the languages:
	update_font_size(0)

func on_menu_item_selected(id: int) -> void:
	var popup = menu_button.get_popup()
	popup.get_item_text(id)

	match id:
		0:# increase font size
			update_font_size(10)
		1:# decrease font size
			update_font_size(-10)
		2:# save
			save_panel.visible = true
		3:# load
			load_panel.visible = true
			load_panel.load_files()
		4:# edit
			edit_default_panel.visible = true
			edit_default_panel.set_values(Global.current_default_tracker)
		5:# tracker manager
			tracker_manager_panel.visible = true
		6:# info
			info_panel.visible = true
		7:# delete trackers
			_delete_all_trackers()
			logs_panel._on_clean_pressed()
		8:# quit
			get_tree().quit()
		_:
			pass

func _on_lang_selected(id: int) -> void:
	if id == 0:
		Global.language_selected = OS.get_locale_language()
	else:
		Global.language_selected = list_lang[id - 1]
	TranslationServer.set_locale(Global.language_selected)
	Global.saver_loader.save_language()

func add_tracker(tracker_info : TrackerInfo) -> void:
	var new_tracker : Tracker = tracker_info.get_tracker()
	all_trackers.add_child(new_tracker)
	new_tracker.update_font_size(Global.current_UI_size)
	
	if tracker_info.is_minimized:
		new_tracker._on_minimize_pressed()
	if tracker_info.is_show_note:
		new_tracker._on_notes_button_pressed()
	
	add_button_margin.reparent(self)
	add_button_margin.reparent(all_trackers)

func update_font_size(amount : int):
	Global.current_UI_size += amount
	TEXT_THEME.set_font_size("font_size", "Button",  Global.current_UI_size)
	
	# main menu
	menu_button.add_theme_font_size_override("font_size", Global.current_UI_size)
	var menu_items : PopupMenu = menu_button.get_popup()
	menu_items.add_theme_font_size_override("font_size", Global.current_UI_size)
	# main menu item size
	for id in menu_items.item_count:
		menu_items.set_item_icon_max_width(id, Global.current_UI_size)
	# lang menu
	lang_menu_button.add_theme_font_size_override("font_size", Global.current_UI_size)
	var lang_items : PopupMenu = lang_menu_button.get_popup()
	lang_items.add_theme_font_size_override("font_size", Global.current_UI_size)
	# lang menu item size
	for id in lang_items.item_count:
		lang_items.set_item_icon_max_width(id, Global.current_UI_size)
	
	for track in all_trackers.get_children():
		if track is Tracker:
			track.update_font_size(Global.current_UI_size)
	
	# update edit default screen
	edit_default_panel.update_color_size()
	
	edit_default_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	edit_default_panel.emoji.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	edit_default_panel.tracker_name.add_theme_font_size_override("font_size", Global.current_UI_size)
	edit_default_panel.tracker_value.add_theme_font_size_override("font_size", Global.current_UI_size)
	edit_default_panel.notes.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	var line_edit : LineEdit = edit_default_panel.tracker_value.get_line_edit()
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	
	# save menu
	save_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	save_panel.actual_save_name.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.space.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.emoji.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	save_panel.title_save.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	
	# load menu
	load_panel.load_title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	load_panel.presets_title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	load_panel.emoji_1.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	load_panel.emoji_2.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	
	# For SpinBox we target the internal LineEdit:
	line_edit = edit_default_panel.m_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = edit_default_panel.m_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = edit_default_panel.p_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = edit_default_panel.p_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	
	# info menu
	info_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	info_panel.emoji.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	info_panel.content.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	
	# logs menu
	logs_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	logs_panel.emoji.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	logs_panel.content.add_theme_font_size_override("normal_font_size", int(Global.current_UI_size/1.3))
	
	# tracker manager
	tracker_manager_panel.emoji.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	tracker_manager_panel.title.add_theme_font_size_override("normal_font_size", Global.current_UI_size)
	for item in tracker_manager_panel.trackers.get_children():
		if item is PreviewTracker:
			item.change_size(Global.current_UI_size)
	
	for item in all_dice.get_children():
		if item is DiceTracker:
			item.set_UI_size()

func _delete_all_trackers() -> void:
	for item in all_trackers.get_children():
		if item is Tracker:
			item.queue_free()
	
	for item in all_dice.get_children():
		if item is DiceTracker:
			item._on_delete_pressed()

func _on_add_button_pressed() -> void:
	var tracker : Tracker = TRACKER.instantiate()
	
	all_trackers.add_child(tracker)
	tracker.update_font_size(Global.current_UI_size)
	
	add_button_margin.reparent(self)
	add_button_margin.reparent(all_trackers)

func _on_logs_button_pressed() -> void:
	logs_panel.visible = true
	await get_tree().process_frame
	logs_panel.on_scroll_down_pressed()

func _on_add_dice_pressed() -> void:
	var new_dice := DICE_TRACKER.instantiate()
	all_dice.add_child(new_dice)
	update_font_size(0)
