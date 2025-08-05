extends VBoxContainer
class_name EditTracker

@onready var tracker_name: TextEdit = $PanelContainer/VBoxContainer/Tittle/TrackerName
@onready var tracker_color: OptionButton = $PanelContainer/VBoxContainer/Tittle/TrackerColor

@onready var button_m_1: OperatorButton = $Body/VBoxContainer/HBoxContainer/ButtonM1
@onready var m_1: SpinBox = $Body/VBoxContainer/HBoxContainer/m1
@onready var button_m_2: OperatorButton = $Body/VBoxContainer/HBoxContainer2/ButtonM2
@onready var m_2: SpinBox = $Body/VBoxContainer/HBoxContainer2/m2
@onready var button_p_1: OperatorButton = $Body/VBoxContainer2/HBoxContainer/ButtonP1
@onready var p_1: SpinBox = $Body/VBoxContainer2/HBoxContainer/p1
@onready var button_p_2: OperatorButton = $Body/VBoxContainer2/HBoxContainer2/ButtonP2
@onready var p_2: SpinBox = $Body/VBoxContainer2/HBoxContainer2/p2
@onready var notes: TextEdit = $Notes
@onready var tracker_value: SpinBox = $Body/TrackerValue

@onready var panel_container: PanelContainer = $PanelContainer

@warning_ignore("unused_signal")
signal name_changed(text_edit : TextEdit)
@warning_ignore("unused_signal")
signal notes_changed(text_edit : TextEdit)

func _ready() -> void:
	update_color_size(Global.current_UI_size)

func get_tracker_info() -> TrackerInfo:
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

func update_color_size(font_size : int):
	# First we change icon shown on the selected item
	var displayed_icon = tracker_color.get_item_icon(tracker_color.get_selected_id())
	tracker_color.add_theme_font_size_override("font_size", font_size)
	tracker_color.set_item_icon(
		tracker_color.get_selected_id(),
		Global.get_scaled_icon(displayed_icon, font_size)
		)
	# Now we change the popup items first the text then the icon
	var popup_color : PopupMenu = tracker_color.get_popup()
	popup_color.add_theme_font_size_override("font_size", font_size)
	for id in tracker_color.item_count:
		popup_color.set_item_icon_max_width(id, font_size)
		var scaled_icon = Global.get_scaled_icon(tracker_color.get_item_icon(id), font_size)
		popup_color.set_item_icon(id, scaled_icon)
	
	var line_edit : LineEdit = m_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", font_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = m_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", font_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = p_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", font_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	line_edit = p_2.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", font_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	
	tracker_name.add_theme_font_size_override("font_size", font_size)
	tracker_value.add_theme_font_size_override("font_size", font_size)
	notes.add_theme_font_size_override("font_size", int(font_size/1.3))
	
	line_edit = tracker_value.get_line_edit()
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	
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

func _on_tracker_color_item_selected(index: Global.COLORS) -> void:
	var style_box = StyleBoxFlat.new()
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

func _on_tracker_name_text_changed() -> void:
	name_changed.emit(tracker_name)

func _on_notes_text_changed() -> void:
	notes_changed.emit(notes)
