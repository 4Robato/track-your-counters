extends PanelContainer
class_name EditPanel

@onready var default_title: RichTextLabel = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/DefaultTitle

@onready var m_1: SpinBox = $MarginContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer/m1
@onready var m_2: SpinBox = $MarginContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer2/m2
@onready var p_1: SpinBox = $MarginContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer/p1
@onready var p_2: SpinBox = $MarginContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer2/p2

@onready var button_m_1: Button = $MarginContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer/ButtonM1
@onready var button_m_2: Button = $MarginContainer/VBoxContainer/Body/VBoxContainer/HBoxContainer2/ButtonM2
@onready var button_p_1: Button = $MarginContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer/ButtonP1
@onready var button_p_2: Button = $MarginContainer/VBoxContainer/Body/VBoxContainer2/HBoxContainer2/ButtonP2

@onready var tracker_name: TextEdit = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/Tittle/TrackerName
@onready var tracker_value: SpinBox = $MarginContainer/VBoxContainer/Body/TrackerValue
@onready var tracker_color: OptionButton = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/Tittle/TrackerColor
@onready var notes: TextEdit = $MarginContainer/VBoxContainer/Notes

var style_box = StyleBoxFlat.new()
@onready var panel_container: PanelContainer = $MarginContainer/VBoxContainer/PanelContainer

var m1_type : Global.BUTTON_TYPE
var m2_type : Global.BUTTON_TYPE
var p1_type : Global.BUTTON_TYPE
var p2_type : Global.BUTTON_TYPE

@onready var save_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/SaveButton
@onready var load_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/LoadButton
@onready var delete_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/DeleteButton

func _ready() -> void:
	set_values(Global.current_default_tracker)
	
	update_color_size()

func _process(delta: float) -> void:
	if Global._compare_trackers(Global.save_file_default_ti, _get_edit_tracker_info()):
		save_button.disabled = true
		load_button.disabled = true
	else:
		save_button.disabled = false
		load_button.disabled = false
	if Global._compare_trackers(Global.save_file_default_ti, Global.DEFAULT_TRACKER_INFO):
		delete_button.disabled = true
	else:
		delete_button.disabled = false

func set_values(info : TrackerInfo) -> void:
	m_1.value = info.button_m1
	m_2.value = info.button_m2
	p_1.value = info.button_p1
	p_2.value = info.button_p2
	m1_type = info.button_m1_type
	m2_type = info.button_m2_type
	p1_type = info.button_p1_type
	p2_type = info.button_p2_type
	tracker_name.text = info.tracker_name
	tracker_value.value = info.tracker_value
	tracker_color.select(info.tracker_color)
	_on_tracker_color_item_selected(info.tracker_color)
	
	notes.text = info.tracker_notes
	
	button_m_1.text = Global._get_button_text(m1_type)
	button_m_2.text = Global._get_button_text(m2_type)
	button_p_1.text = Global._get_button_text(p1_type)
	button_p_2.text = Global._get_button_text(p2_type)

func update_color_size():
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
		m1_type,
		int(m_2.value),
		m2_type,
		int(p_1.value),
		p1_type,
		int(p_2.value),
		p2_type,
		tracker_name.text,
		tracker_value.value,
		tracker_color.get_selected_id(),
		notes.text
	)
	return tracker_info

func _on_button_m_1_pressed() -> void:
	match Global._get_button_type(button_m_1):
		Global.BUTTON_TYPE.MINUS:
			button_m_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			m1_type = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_m_1.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			m1_type = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_m_1.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			m1_type = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_m_1.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			m1_type = Global.BUTTON_TYPE.MINUS
		_:
			button_m_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			m1_type = Global.BUTTON_TYPE.PLUS


func _on_button_m_2_pressed() -> void:
	match Global._get_button_type(button_m_2):
		Global.BUTTON_TYPE.MINUS:
			button_m_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			m2_type = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_m_2.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			m2_type = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_m_2.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			m2_type = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_m_2.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			m2_type = Global.BUTTON_TYPE.MINUS
		_:
			button_m_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			m2_type = Global.BUTTON_TYPE.PLUS

func _on_button_p_1_pressed() -> void:
	match Global._get_button_type(button_p_1):
		Global.BUTTON_TYPE.MINUS:
			button_p_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			p1_type = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_p_1.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			p1_type = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_p_1.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			p1_type = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_p_1.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			p1_type = Global.BUTTON_TYPE.MINUS
		_:
			button_p_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			p1_type = Global.BUTTON_TYPE.PLUS

func _on_button_p_2_pressed() -> void:
	match Global._get_button_type(button_p_2):
		Global.BUTTON_TYPE.MINUS:
			button_p_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			p2_type = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_p_2.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			p2_type = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_p_2.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			p2_type = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_p_2.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			p2_type = Global.BUTTON_TYPE.MINUS
		_:
			button_p_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			p2_type = Global.BUTTON_TYPE.PLUS

func _on_tracker_color_item_selected(index: int) -> void:
	var color_sel : Color
	match index:
		0:#black
			color_sel = Color(0, 0, 0, 0.39)
		1:#white
			color_sel = Color(1, 1, 1, 0.39)
		2:#yellow
			color_sel = Color(1, 1, 0, 0.39)
		3:#red
			color_sel = Color(1, 0, 0, 0.39)
		4:#blue
			color_sel = Color(0, 0, 1, 0.39)
		5:#light blue
			color_sel = Color(0.678, 0.847, 0.902, 0.39)
		6:#green
			color_sel = Color(0, 1, 0, 0.39)
		7:#brown
			color_sel = Color(0.647, 0.165, 0.165, 0.39)
		8:#orange
			color_sel = Color(1, 0.647, 0, 0.39)
		_:#default = Black
			color_sel = Color(0, 0, 0, 0.39)
	
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
	
	button_m_1.add_theme_stylebox_override("normal", style_box)
	button_m_2.add_theme_stylebox_override("normal", style_box)
	button_p_1.add_theme_stylebox_override("normal", style_box)
	button_p_2.add_theme_stylebox_override("normal", style_box)

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
