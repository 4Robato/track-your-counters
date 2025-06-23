class_name Tracker
extends MarginContainer

@onready var panel_container: PanelContainer = $VBoxContainer/PanelContainer
@onready var tracker_name: TextEdit = $VBoxContainer/PanelContainer/HBoxContainer/TrackerName

@onready var minus_1: ButtonModifier = $VBoxContainer/HBoxContainer/minus/minus1
@onready var minus_2: ButtonModifier = $VBoxContainer/HBoxContainer/minus/minus2
@onready var plus_1: ButtonModifier = $VBoxContainer/HBoxContainer/plus/plus1
@onready var plus_2: ButtonModifier = $VBoxContainer/HBoxContainer/plus/plus2

@onready var edit: Button = $VBoxContainer/PanelContainer/HBoxContainer/Edit
@onready var location: SpinBox = $VBoxContainer/PanelContainer/HBoxContainer/Location
@onready var cancel: Button = $VBoxContainer/PanelContainer/HBoxContainer/Cancel
@onready var minimize: Button = $VBoxContainer/PanelContainer/HBoxContainer/minimize
@onready var close: Button = $VBoxContainer/PanelContainer/HBoxContainer/close

@onready var h_box_container: HBoxContainer = $VBoxContainer/HBoxContainer
@onready var tracker_value: LineEdit = $VBoxContainer/HBoxContainer/TrackerValue

@onready var h_box_line_editm_1: HBoxContainer = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm1
@onready var h_box_line_editm_2: HBoxContainer = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm2
@onready var h_box_line_editp_1: HBoxContainer = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp1
@onready var h_box_line_editp_2: HBoxContainer = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp2

@onready var button_line_editm_1: Button = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm1/ButtonLineEditm1
@onready var button_line_editm_2: Button = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm2/ButtonLineEditm2
@onready var button_line_editp_1: Button = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp1/ButtonLineEditp1
@onready var button_line_editp_2: Button = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp2/ButtonLineEditp2

@onready var line_editm_1: SpinBox = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm1/LineEditm1
@onready var line_editm_2: SpinBox = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm2/LineEditm2
@onready var line_editp_1: SpinBox = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp1/LineEditp1
@onready var line_editp_2: SpinBox = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp2/LineEditp2

@onready var color_button: OptionButton = $VBoxContainer/PanelContainer/HBoxContainer/ColorButton
@onready var notes_button: Button = $VBoxContainer/PanelContainer/HBoxContainer/NotesButton

@onready var notes: TextEdit = $VBoxContainer/Notes


@export var minus_low : int
@export var minus_high : int
@export var plus_low: int
@export var plus_high : int

var t_info : TrackerInfo

var edit_mode : bool = false
var is_minimized : bool = false
var notes_mode : bool = false

var style_box = StyleBoxFlat.new()
var current_color : int = 0
var color_selected : int = 0

func _ready() -> void:
	t_info = Global.default_tracker
	_set_tracker_info(t_info)
	
	line_editm_1.value = minus_1.value
	line_editm_2.value = minus_2.value
	line_editp_1.value = plus_1.value
	line_editp_2.value = plus_2.value

func _on_minus_1_pressed() -> void:
	var tracker_value_int : int = int(tracker_value.text)
	match minus_1.type:
		Global.BUTTON_TYPE.MINUS:
			tracker_value_int -= minus_1.value
		Global.BUTTON_TYPE.PLUS:
			tracker_value_int += minus_1.value
		Global.BUTTON_TYPE.MULTIPLY:
			tracker_value_int *= minus_1.value
		Global.BUTTON_TYPE.DIVIDE:
			tracker_value_int /= minus_1.value
		_:
			pass
	tracker_value.text = str(tracker_value_int)

func _on_minus_2_pressed() -> void:
	var tracker_value_int : int = int(tracker_value.text)
	match minus_2.type:
		Global.BUTTON_TYPE.MINUS:
			tracker_value_int -= minus_2.value
		Global.BUTTON_TYPE.PLUS:
			tracker_value_int += minus_2.value
		Global.BUTTON_TYPE.MULTIPLY:
			tracker_value_int *= minus_2.value
		Global.BUTTON_TYPE.DIVIDE:
			tracker_value_int /= minus_2.value
		_:
			pass
	tracker_value.text = str(tracker_value_int)

func _on_plus_1_pressed() -> void:
	var tracker_value_int : int = int(tracker_value.text)
	match plus_1.type:
		Global.BUTTON_TYPE.MINUS:
			tracker_value_int -= plus_1.value
		Global.BUTTON_TYPE.PLUS:
			tracker_value_int += plus_1.value
		Global.BUTTON_TYPE.MULTIPLY:
			tracker_value_int *= plus_1.value
		Global.BUTTON_TYPE.DIVIDE:
			tracker_value_int /= plus_1.value
		_:
			pass
	tracker_value.text = str(tracker_value_int)

func _on_plus_2_pressed() -> void:
	var tracker_value_int : int = int(tracker_value.text)
	match plus_2.type:
		Global.BUTTON_TYPE.MINUS:
			tracker_value_int -= plus_2.value
		Global.BUTTON_TYPE.PLUS:
			tracker_value_int += plus_2.value
		Global.BUTTON_TYPE.MULTIPLY:
			tracker_value_int *= plus_2.value
		Global.BUTTON_TYPE.DIVIDE:
			tracker_value_int /= plus_2.value
		_:
			pass
	tracker_value.text = str(tracker_value_int)

func _on_close_pressed() -> void:
	self.queue_free()

func _on_minimize_pressed() -> void:
	if !is_minimized:
		minimize.text = "  ◇  "
	else:
		minimize.text = "  —  "
	
	if notes_mode and !is_minimized:
		notes.visible = false
		is_minimized = true
		notes_mode = false
	elif notes_mode and is_minimized:
		notes.visible = false
		edit.visible = true
		is_minimized = false
		notes_mode = false
		
		h_box_container.visible = !h_box_container.visible
		h_box_container.size_flags_vertical = !h_box_container.size_flags_vertical
		self.size_flags_vertical = !self.size_flags_vertical
	elif !notes_mode:
		edit.visible = !edit.visible
		
		h_box_container.visible = !h_box_container.visible
		h_box_container.size_flags_vertical = !h_box_container.size_flags_vertical
		self.size_flags_vertical = !self.size_flags_vertical
	
		is_minimized = !is_minimized

func _on_tracker_value_text_submitted(new_text: String) -> void:
	tracker_value.text = str(int(new_text))

func _reverse_visible():
	edit_mode = !edit_mode
	if edit.text == "  ✔️  ":
		edit.text = "  ✏️  "
	else:
		edit.text = "  ✔️  "
	
	cancel.visible = !cancel.visible
	location.visible = !location.visible
	minimize.visible = !minimize.visible
	close.visible = !close.visible
	
	color_button.visible = !color_button.visible
	
	notes_button.visible = !notes_button.visible
	
	h_box_line_editm_1.visible = !h_box_line_editm_1.visible
	h_box_line_editm_2.visible = !h_box_line_editm_2.visible
	h_box_line_editp_1.visible = !h_box_line_editp_1.visible
	h_box_line_editp_2.visible = !h_box_line_editp_2.visible
	
	minus_1.visible = !minus_1.visible
	minus_2.visible = !minus_2.visible
	plus_1.visible = !plus_1.visible
	plus_2.visible = !plus_2.visible

# Edit Button
func _on_edit_pressed() -> void:
	_reverse_visible()
	
	if edit_mode:
		location.value = get_index() + 1
	
	# This activates when you exit edit mode and you pressed the button
	if !edit_mode:
		# (when accept edit)
		minus_1.value = int(line_editm_1.value)
		minus_2.value = int(line_editm_2.value)
		plus_1.value = int(line_editp_1.value)
		plus_2.value = int(line_editp_2.value)
		
		minus_1.type = minus_1.type_edit
		minus_2.type = minus_2.type_edit
		plus_1.type = plus_1.type_edit
		plus_2.type = plus_2.type_edit
		
		if location.value != get_index() + 1:
			if location.value >= get_parent().get_child_count():
				location.value = get_parent().get_child_count() - 1
			var parent = get_parent()
			parent.move_child(self, int(location.value) - 1)
		
		current_color = color_selected

func _on_cancel_pressed() -> void:
	_on_color_button_item_selected(current_color)
	color_button.select(current_color)
	
	_reverse_visible()
	
	line_editm_1.value = minus_1.value
	line_editm_2.value = minus_2.value
	line_editp_1.value = plus_1.value
	line_editp_2.value = plus_2.value
	
	button_line_editm_1.text = Global._get_button_text(minus_1.type)
	button_line_editm_2.text = Global._get_button_text(minus_2.type)
	button_line_editp_1.text = Global._get_button_text(plus_1.type)
	button_line_editp_2.text = Global._get_button_text(plus_2.type)

func _on_color_button_item_selected(index: int) -> void:
	var color_sel : Color
	color_selected = index
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
	minus_1.add_theme_stylebox_override("normal", style_box)
	minus_2.add_theme_stylebox_override("normal", style_box)
	plus_1.add_theme_stylebox_override("normal", style_box)
	plus_2.add_theme_stylebox_override("normal", style_box)
	tracker_value.add_theme_stylebox_override("normal", style_box)
	#tracker_name.add_theme_stylebox_override("normal", style_box)
	notes.add_theme_stylebox_override("normal", style_box)
	
	line_editm_1.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editm_2.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editp_1.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editp_2.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	

func update_font_size(text_size : int):
	tracker_name.add_theme_font_size_override("font_size", text_size)
	tracker_value.add_theme_font_size_override("font_size", text_size)
	notes.add_theme_font_size_override("font_size", int(text_size/1.3))
	
	minus_1.add_theme_font_size_override("font_size", text_size)
	minus_2.add_theme_font_size_override("font_size", text_size)
	plus_1.add_theme_font_size_override("font_size", text_size)
	plus_2.add_theme_font_size_override("font_size", text_size)
	
	# For SpinBox we target the internal LineEdit:
	var line_edit : LineEdit = line_editm_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", text_size)
	var line_edit_2 : LineEdit = line_editm_2.get_line_edit()
	line_edit_2.add_theme_font_size_override("font_size", text_size)
	var line_edit_3 : LineEdit = line_editp_1.get_line_edit()
	line_edit_3.add_theme_font_size_override("font_size", text_size)
	var line_edit_4 : LineEdit = line_editp_2.get_line_edit()
	line_edit_4.add_theme_font_size_override("font_size", text_size)
	
	var location_line_edit : LineEdit = location.get_line_edit()
	location_line_edit.add_theme_font_size_override("font_size", text_size)
	
	# First we change icon shown on the selected item
	var displayed_icon = color_button.get_item_icon(color_button.get_selected_id())
	color_button.add_theme_font_size_override("font_size", text_size)
	color_button.set_item_icon(
		color_button.get_selected_id(),
		Global.get_scaled_icon(displayed_icon, text_size)
		)
	# Now we change the popup items first the text then the icon
	var popup_color : PopupMenu = color_button.get_popup()
	popup_color.add_theme_font_size_override("font_size", text_size)
	for id in color_button.item_count:
		popup_color.set_item_icon_max_width(id, text_size)
		var scaled_icon = Global.get_scaled_icon(color_button.get_item_icon(id), text_size)
		popup_color.set_item_icon(id, scaled_icon)


func _on_notes_button_pressed() -> void:
	if notes_mode and !is_minimized:
		notes.visible = false
		edit.visible = true
		h_box_container.visible = true
	elif notes_mode and is_minimized:
		notes.visible = false
	elif !notes_mode:
		notes.visible = true
		edit.visible = false
		h_box_container.visible = false
	
	notes_mode = !notes_mode

func _on_button_line_editm_1_pressed() -> void:
	match Global._get_button_type(button_line_editm_1):
		Global.BUTTON_TYPE.MINUS:
			button_line_editm_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			minus_1.type_edit = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_line_editm_1.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			minus_1.type_edit = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_line_editm_1.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			minus_1.type_edit = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_line_editm_1.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			minus_1.type_edit = Global.BUTTON_TYPE.MINUS
		_:
			button_line_editm_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			minus_1.type_edit = Global.BUTTON_TYPE.PLUS

func _on_button_line_editm_2_pressed() -> void:
	match Global._get_button_type(button_line_editm_2):
		Global.BUTTON_TYPE.MINUS:
			button_line_editm_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			minus_2.type_edit = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_line_editm_2.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			minus_2.type_edit = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_line_editm_2.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			minus_2.type_edit = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_line_editm_2.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			minus_2.type_edit = Global.BUTTON_TYPE.MINUS
		_:
			button_line_editm_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			minus_2.type_edit = Global.BUTTON_TYPE.PLUS

func _on_button_line_editp_1_pressed() -> void:
	match Global._get_button_type(button_line_editp_1):
		Global.BUTTON_TYPE.MINUS:
			button_line_editp_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			plus_1.type_edit = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_line_editp_1.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			plus_1.type_edit = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_line_editp_1.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			plus_1.type_edit = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_line_editp_1.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			plus_1.type_edit = Global.BUTTON_TYPE.MINUS
		_:
			button_line_editp_1.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			plus_1.type_edit = Global.BUTTON_TYPE.PLUS

func _on_button_line_editp_2_pressed() -> void:
	match Global._get_button_type(button_line_editp_2):
		Global.BUTTON_TYPE.MINUS:
			button_line_editp_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			plus_2.type_edit = Global.BUTTON_TYPE.PLUS
		Global.BUTTON_TYPE.PLUS:
			button_line_editp_2.text = Global._get_button_text(Global.BUTTON_TYPE.MULTIPLY)
			plus_2.type_edit = Global.BUTTON_TYPE.MULTIPLY
		Global.BUTTON_TYPE.MULTIPLY:
			button_line_editp_2.text = Global._get_button_text(Global.BUTTON_TYPE.DIVIDE)
			plus_2.type_edit = Global.BUTTON_TYPE.DIVIDE
		Global.BUTTON_TYPE.DIVIDE:
			button_line_editp_2.text = Global._get_button_text(Global.BUTTON_TYPE.MINUS)
			plus_2.type_edit = Global.BUTTON_TYPE.MINUS
		_:
			button_line_editp_2.text = Global._get_button_text(Global.BUTTON_TYPE.PLUS)
			plus_2.type_edit = Global.BUTTON_TYPE.PLUS

func get_tracker_info() -> TrackerInfo:
	var info : TrackerInfo = TrackerInfo.new(
		minus_1.value,
		minus_1.type,
		minus_2.value,
		minus_2.type,
		plus_1.value,
		plus_1.type,
		plus_2.value,
		plus_2.type,
		tracker_name.text,
		int(tracker_value.text),
		current_color,
		notes.text
	)
	return info

func _set_tracker_info(info : TrackerInfo) -> void:
	minus_1.value = info.button_m1
	minus_1.type = info.button_m1_type
	minus_2.value = info.button_m2
	minus_2.type = info.button_m2_type
	plus_1.value = info.button_p1
	plus_1.type = info.button_p1_type
	plus_2.value = info.button_p2
	plus_2.type = info.button_p2_type
	tracker_name.text = info.tracker_name
	tracker_value.text = str(info.tracker_value)
	current_color = info.tracker_color# this is so when we cancel the selected is known
	color_button.select(info.tracker_color)# change the selection on the dropdown
	_on_color_button_item_selected(info.tracker_color)# change the actual color
	notes.text = info.tracker_notes
