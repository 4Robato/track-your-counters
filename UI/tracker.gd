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
@onready var tracker_value: SpinBox = $VBoxContainer/HBoxContainer/TrackerValue

@onready var h_box_line_editm_1: HBoxContainer = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm1
@onready var h_box_line_editm_2: HBoxContainer = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm2
@onready var h_box_line_editp_1: HBoxContainer = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp1
@onready var h_box_line_editp_2: HBoxContainer = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp2

@onready var button_line_editm_1: OperatorButton = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm1/ButtonLineEditm1
@onready var button_line_editm_2: OperatorButton = $VBoxContainer/HBoxContainer/minus/HBoxLineEditm2/ButtonLineEditm2
@onready var button_line_editp_1: OperatorButton = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp1/ButtonLineEditp1
@onready var button_line_editp_2: OperatorButton = $VBoxContainer/HBoxContainer/plus/HBoxLineEditp2/ButtonLineEditp2

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

var last_tracker_value : int

var t_info : TrackerInfo

var edit_mode : bool = false
var is_minimized : bool = false
var notes_mode : bool = false

var style_box = StyleBoxFlat.new()
var current_color :  Global.COLORS = Global.COLORS.BLACK
var color_selected : Global.COLORS = Global.COLORS.BLACK

var log_tracker : LogTracker = LogTracker.new()

@warning_ignore("unused_signal")
signal name_changed(text_edit : TextEdit)
@warning_ignore("unused_signal")
signal notes_changed(text_edit : TextEdit)

# this value is used to not send a signal everytime the tracker_value changes
# and only when the value is changed by hand
var manual_change : bool

func _ready() -> void:
	if t_info == null:
		t_info = Global.current_default_tracker
	_set_tracker_info(t_info)
	
	line_editm_1.value = minus_1.value
	line_editm_2.value = minus_2.value
	line_editp_1.value = plus_1.value
	line_editp_2.value = plus_2.value
	
	var line_edit : LineEdit = location.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	
	line_edit = line_editm_1.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = line_editm_2.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = line_editp_1.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	line_edit = line_editp_2.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	
	current_color = color_button.get_selected_id() as Global.COLORS
	color_selected = color_button.get_selected_id() as Global.COLORS
	
	last_tracker_value = int(tracker_value.value)
	
	manual_change = true

func _on_minus_1_pressed() -> void:
	manual_change = false
	
	log_tracker.value_pre = int(tracker_value.value)
	match minus_1.type:
		OperatorButton.BUTTON_TYPE.MINUS:
			tracker_value.value -= minus_1.value
		OperatorButton.BUTTON_TYPE.PLUS:
			tracker_value.value += minus_1.value
		OperatorButton.BUTTON_TYPE.MULTIPLY:
			tracker_value.value *= minus_1.value
		OperatorButton.BUTTON_TYPE.DIVIDE:
			tracker_value.value /= minus_1.value
		_:
			pass
	
	log_tracker.operator_type = minus_1.type
	log_tracker.operator_value = minus_1.value
	log_tracker.value_post = int(tracker_value.value)
	_text_to_log()
	
	last_tracker_value = int(tracker_value.value)

func _on_minus_2_pressed() -> void:
	manual_change = false
	
	log_tracker.value_pre = int(tracker_value.value)
	match minus_2.type:
		OperatorButton.BUTTON_TYPE.MINUS:
			tracker_value.value -= minus_2.value
		OperatorButton.BUTTON_TYPE.PLUS:
			tracker_value.value += minus_2.value
		OperatorButton.BUTTON_TYPE.MULTIPLY:
			tracker_value.value *= minus_2.value
		OperatorButton.BUTTON_TYPE.DIVIDE:
			tracker_value.value /= minus_2.value
		_:
			pass
	log_tracker.operator_type = minus_2.type
	log_tracker.operator_value = minus_2.value
	log_tracker.value_post = int(tracker_value.value)
	_text_to_log()
	
	last_tracker_value = int(tracker_value.value)

func _on_plus_1_pressed() -> void:
	manual_change = false
	
	log_tracker.value_pre = int(tracker_value.value)
	match plus_1.type:
		OperatorButton.BUTTON_TYPE.MINUS:
			tracker_value.value -= plus_1.value
		OperatorButton.BUTTON_TYPE.PLUS:
			tracker_value.value += plus_1.value
		OperatorButton.BUTTON_TYPE.MULTIPLY:
			tracker_value.value *= plus_1.value
		OperatorButton.BUTTON_TYPE.DIVIDE:
			tracker_value.value /= plus_1.value
		_:
			pass
	log_tracker.operator_type = plus_1.type
	log_tracker.operator_value = plus_1.value
	log_tracker.value_post = int(tracker_value.value)
	_text_to_log()
	
	last_tracker_value = int(tracker_value.value)

func _on_plus_2_pressed() -> void:
	manual_change = false
	
	log_tracker.value_pre = int(tracker_value.value)
	match plus_2.type:
		OperatorButton.BUTTON_TYPE.MINUS:
			tracker_value.value -= plus_2.value
		OperatorButton.BUTTON_TYPE.PLUS:
			tracker_value.value += plus_2.value
		OperatorButton.BUTTON_TYPE.MULTIPLY:
			tracker_value.value *= plus_2.value
		OperatorButton.BUTTON_TYPE.DIVIDE:
			tracker_value.value /= plus_2.value
		_:
			pass
	log_tracker.operator_type = plus_2.type
	log_tracker.operator_value = plus_2.value
	log_tracker.value_post = int(tracker_value.value)
	_text_to_log()
	
	last_tracker_value = int(tracker_value.value)

func _on_close_pressed() -> void:
	self.queue_free()

func _on_minimize_pressed() -> void:
	if !is_minimized:
		minimize.text = " ➕ "
	else:
		minimize.text = " ➖ "
	
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

func _reverse_visible():
	edit_mode = !edit_mode
	if edit.text == " ✔️ ":
		edit.text = " ✏️ "
	else:
		edit.text = " ✔️ "
	
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
		
		button_line_editm_1.operator_type = minus_1.type
		button_line_editm_2.operator_type = minus_2.type
		button_line_editp_1.operator_type = plus_1.type
		button_line_editp_2.operator_type = plus_2.type
	
	# This activates when you exit edit mode and you pressed the button
	if !edit_mode:
		# (when accept edit)
		minus_1.value = int(line_editm_1.value)
		minus_2.value = int(line_editm_2.value)
		plus_1.value = int(line_editp_1.value)
		plus_2.value = int(line_editp_2.value)
		
		minus_1.type = button_line_editm_1.operator_type
		minus_2.type = button_line_editm_2.operator_type
		plus_1.type = button_line_editp_1.operator_type
		plus_2.type = button_line_editp_2.operator_type
		
		if location.value != get_index() + 1:
			if location.value >= get_parent().get_child_count():
				location.value = get_parent().get_child_count() - 1
			var parent = get_parent()
			parent.move_child(self, int(location.value) - 1)
		
		current_color = color_selected

func _on_cancel_pressed() -> void:
	_on_color_button_item_selected(current_color as Global.COLORS)
	color_button.select(current_color as Global.COLORS)
	
	_reverse_visible()
	
	line_editm_1.value = minus_1.value
	line_editm_2.value = minus_2.value
	line_editp_1.value = plus_1.value
	line_editp_2.value = plus_2.value
	

func _on_color_button_item_selected(color: Global.COLORS) -> void:
	var color_sel : Color = Global.convert_to_color(color)
	color_selected = color
	
	style_box.bg_color = color_sel
	
	panel_container.add_theme_stylebox_override("panel", style_box)
	minus_1.add_theme_stylebox_override("normal", style_box)
	minus_2.add_theme_stylebox_override("normal", style_box)
	plus_1.add_theme_stylebox_override("normal", style_box)
	plus_2.add_theme_stylebox_override("normal", style_box)
	notes.add_theme_stylebox_override("normal", style_box)
	
	line_editm_1.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editm_2.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editp_1.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	line_editp_2.add_theme_stylebox_override("field_and_buttons_separator", style_box)
	
	# For SpinBox we target the internal LineEdit:
	var line_edit_tv : LineEdit = tracker_value.get_line_edit()
	line_edit_tv.add_theme_stylebox_override("normal", style_box)
	
	var line_edit : LineEdit = line_editm_1.get_line_edit()
	line_edit.add_theme_stylebox_override("normal", style_box)
	var line_edit_2 : LineEdit = line_editm_2.get_line_edit()
	line_edit_2.add_theme_stylebox_override("normal", style_box)
	var line_edit_3 : LineEdit = line_editp_1.get_line_edit()
	line_edit_3.add_theme_stylebox_override("normal", style_box)
	var line_edit_4 : LineEdit = line_editp_2.get_line_edit()
	line_edit_4.add_theme_stylebox_override("normal", style_box)

func update_font_size(text_size : int):
	tracker_name.add_theme_font_size_override("font_size", text_size)
	notes.add_theme_font_size_override("font_size", int(text_size/1.3))
	
	minus_1.add_theme_font_size_override("font_size", text_size)
	minus_2.add_theme_font_size_override("font_size", text_size)
	plus_1.add_theme_font_size_override("font_size", text_size)
	plus_2.add_theme_font_size_override("font_size", text_size)
	
	# For SpinBox we target the internal LineEdit:
	var line_edit_tv : LineEdit = tracker_value.get_line_edit()
	line_edit_tv.add_theme_font_size_override("font_size", text_size)
	line_edit_tv.add_theme_constant_override("minimum_character_width", 1)
	
	var line_edit : LineEdit = line_editm_1.get_line_edit()
	line_edit.add_theme_font_size_override("font_size", text_size)
	line_edit.add_theme_constant_override("minimum_character_width", 1)
	var line_edit_2 : LineEdit = line_editm_2.get_line_edit()
	line_edit_2.add_theme_font_size_override("font_size", text_size)
	line_edit_2.add_theme_constant_override("minimum_character_width", 1)
	var line_edit_3 : LineEdit = line_editp_1.get_line_edit()
	line_edit_3.add_theme_font_size_override("font_size", text_size)
	line_edit_3.add_theme_constant_override("minimum_character_width", 1)
	var line_edit_4 : LineEdit = line_editp_2.get_line_edit()
	line_edit_4.add_theme_font_size_override("font_size", text_size)
	line_edit_4.add_theme_constant_override("minimum_character_width", 1)
	
	var location_line_edit : LineEdit = location.get_line_edit()
	location_line_edit.add_theme_font_size_override("font_size", text_size)
	location_line_edit.add_theme_constant_override("minimum_character_width", 3)
	
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
		int(tracker_value.value),
		current_color,
		notes.text,
		is_minimized,
		notes_mode
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
	tracker_value.value = info.tracker_value
	current_color = info.tracker_color# this is so when we cancel the selected is known
	color_button.select(info.tracker_color)# change the selection on the dropdown
	_on_color_button_item_selected(info.tracker_color)# change the actual color
	notes.text = info.tracker_notes

func _text_to_log() -> void:
	log_tracker.tracker_name = tracker_name.text
	log_tracker.location = get_index() + 1
	log_tracker.tracker_color = current_color as Global.COLORS
	
	Global.add_log_tacker.emit(log_tracker)


func _on_tracker_value_value_changed(value: float) -> void:
	if manual_change:
		log_tracker.value_pre = last_tracker_value
		log_tracker.operator_type = OperatorButton.BUTTON_TYPE.HAND
		log_tracker.value_post = int(value)
		_text_to_log()
		last_tracker_value = int(value)
	else:
		manual_change = true

func _on_tracker_name_focus_entered() -> void:
	name_changed.emit(tracker_name)

func _on_tracker_name_text_changed() -> void:
	name_changed.emit(tracker_name)

func _on_notes_focus_entered() -> void:
	notes_changed.emit(notes)

func _on_notes_text_changed() -> void:
	notes_changed.emit(notes)
