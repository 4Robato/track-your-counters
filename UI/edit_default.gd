extends PanelContainer
class_name EditPanel

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Title
@onready var emoji: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Emoji
@onready var close_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/CloseButton

@onready var m_1: SpinBox = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer/m1
@onready var m_2: SpinBox = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer2/m2
@onready var p_1: SpinBox = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer/p1
@onready var p_2: SpinBox = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer2/p2

@onready var button_m_1: OperatorButton = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer/ButtonM1
@onready var button_m_2: OperatorButton = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer2/ButtonM2
@onready var button_p_1: OperatorButton = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer/ButtonP1
@onready var button_p_2: OperatorButton = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer2/ButtonP2

@onready var tracker_name: TextEdit = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/PanelContainer/VBoxContainer/Tittle/TrackerName
@onready var tracker_value: SpinBox = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Body/TrackerValue
@onready var tracker_color: OptionButton = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/PanelContainer/VBoxContainer/Tittle/TrackerColor
@onready var notes: TextEdit = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Notes

var style_box = StyleBoxFlat.new()
@onready var panel_container: PanelContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/PanelContainer

@onready var save_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/SaveButton
@onready var load_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/LoadButton
@onready var delete_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/DeleteButton

@onready var scroll_container: ScrollContainer = $MarginContainer/VBoxContainer/ScrollContainer

func _ready() -> void:
	set_values(Global.current_default_tracker)
	
	update_color_size()
	
	var line_edit : LineEdit = m_1.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = m_2.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = p_1.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = p_2.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER

func _process(_delta: float) -> void:
	if Global.compare_trackers(Global.save_file_default_ti, _get_edit_tracker_info()):
		save_button.disabled = true
		load_button.disabled = true
	else:
		save_button.disabled = false
		load_button.disabled = false
	if Global.compare_trackers(Global.save_file_default_ti, Global.DEFAULT_TRACKER_INFO):
		delete_button.disabled = true
	else:
		delete_button.disabled = false

func set_values(info : TrackerInfo) -> void:
	m_1.value = info.button_m1
	m_2.value = info.button_m2
	p_1.value = info.button_p1
	p_2.value = info.button_p2
	button_m_1.operator_type = info.button_m1_type
	button_m_2.operator_type = info.button_m2_type
	button_p_1.operator_type = info.button_p1_type
	button_p_2.operator_type = info.button_p2_type
	tracker_name.text = info.tracker_name
	tracker_value.value = info.tracker_value
	tracker_color.select(info.tracker_color)
	_on_tracker_color_item_selected(info.tracker_color as Global.COLORS)
	
	notes.text = info.tracker_notes

func update_color_size():
	notes.add_theme_font_size_override("font_size", int(Global.current_UI_size/1.3))
	# First we change icon shown on the selected item
	var displayed_icon = tracker_color.get_item_icon(tracker_color.get_selected_id())
	tracker_color.add_theme_font_size_override("font_size", Global.current_UI_size)
	tracker_color.set_item_icon(
		tracker_color.get_selected_id(),
		Global.get_scaled_icon(displayed_icon, Global.current_UI_size)
		)
	# Now we change the popup items first the text then the icon
	var popup_color : PopupMenu = tracker_color.get_popup()
	popup_color.add_theme_font_size_override("font_size", Global.current_UI_size)
	for id in tracker_color.item_count:
		popup_color.set_item_icon_max_width(id, Global.current_UI_size)
		var scaled_icon = Global.get_scaled_icon(tracker_color.get_item_icon(id), Global.current_UI_size)
		popup_color.set_item_icon(id, scaled_icon)

func _get_edit_tracker_info() -> TrackerInfo:
	var tracker_info : TrackerInfo = TrackerInfo.new(
		int(m_1.value),
		button_m_1.operator_type,
		int(m_2.value),
		button_m_2.operator_type,
		int(p_1.value),
		button_p_1.operator_type,
		int(p_2.value),
		button_p_2.operator_type,
		tracker_name.text,
		int(tracker_value.value),
		tracker_color.get_selected_id(),
		notes.text
	)
	return tracker_info

func _on_tracker_color_item_selected(index: Global.COLORS) -> void:
	var color_sel : Color = Global.convert_to_color(index)
	
	style_box.bg_color = color_sel
	panel_container.add_theme_stylebox_override("panel", style_box)
	notes.add_theme_stylebox_override("normal", style_box)
	
	# For SpinBox we target the internal LineEdit:
	var line_edit_tv : LineEdit = tracker_value.get_line_edit()
	line_edit_tv.add_theme_stylebox_override("normal", style_box)
	line_edit_tv.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	var line_edit_m1 : LineEdit = m_1.get_line_edit()
	line_edit_m1.add_theme_stylebox_override("normal", style_box)
	var line_edit_m2 : LineEdit = m_2.get_line_edit()
	line_edit_m2.add_theme_stylebox_override("normal", style_box)
	var line_edit_p1 : LineEdit = p_1.get_line_edit()
	line_edit_p1.add_theme_stylebox_override("normal", style_box)
	var line_edit_p2 : LineEdit = p_2.get_line_edit()
	line_edit_p2.add_theme_stylebox_override("normal", style_box)

func _on_save_button_pressed() -> void:
	_on_accept_button_pressed()
	Global.saver_loader.save_default_tracker()

func _on_load_button_pressed() -> void:
	set_values(Global.load_tracker)

func _on_delete_button_pressed() -> void:
	Global.current_default_tracker = TrackerInfo.new()
	Global.load_tracker = Global.current_default_tracker
	Global.saver_loader.save_default_tracker()
	set_values(Global.current_default_tracker)

func _on_accept_button_pressed() -> void:
	self.visible = false
	var new_default : TrackerInfo = _get_edit_tracker_info()
	Global.current_default_tracker = new_default

func _on_cancel_button_pressed() -> void:
	self.visible = false
	set_values(Global.current_default_tracker)

func _on_notes_text_changed() -> void:
	var num_lines : int = notes.get_line_count()
	var cursor_line : int = notes.get_caret_line() + 1
	var ratio_line : float = float(cursor_line)/num_lines
	var ratio_scroll : float = scroll_container.get_v_scroll_bar().max_value*ratio_line
	scroll_container.call_deferred("set", "scroll_vertical", ratio_scroll)

func _on_close_button_pressed() -> void:
	self.visible = false
	set_values(Global.current_default_tracker)
