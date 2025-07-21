extends HBoxContainer
class_name PreviewTracker

@onready var notes_container: PanelContainer = $VBoxContainer/NotesContainer
@onready var notes: RichTextLabel = $VBoxContainer/NotesContainer/Notes

@onready var tracker_name: RichTextLabel = $VBoxContainer/TitleContainer/background/TrackerName
@onready var m_1: RichTextLabel = $VBoxContainer/ValuesContainer/HBoxContainer/M/M1
@onready var m_2: RichTextLabel = $VBoxContainer/ValuesContainer/HBoxContainer/M/M2
@onready var p_1: RichTextLabel = $VBoxContainer/ValuesContainer/HBoxContainer/P/P1
@onready var p_2: RichTextLabel = $VBoxContainer/ValuesContainer/HBoxContainer/P/P2
@onready var tracker_value: RichTextLabel = $VBoxContainer/ValuesContainer/HBoxContainer/Value

@onready var values_container: PanelContainer = $VBoxContainer/ValuesContainer
@onready var title_container: PanelContainer = $VBoxContainer/TitleContainer

var t_info : TrackerInfo = Global.current_default_tracker

func _ready() -> void:
	set_values(t_info)
	change_size(Global.current_UI_size)

func _on_accept_pressed() -> void:
	Global.add_custom_tracker.emit(t_info)

func _on_edit_pressed() -> void:
	Global.edit_custom_tracker.emit(self)

func _on_delete_pressed() -> void:
	queue_free()

func set_values(tracker_info : TrackerInfo) -> void:
	t_info = tracker_info
	var style_box = StyleBoxFlat.new()
	
	tracker_name.text = t_info.tracker_name
	m_1.text = Global.op_type_to_text(t_info.button_m1_type) + str(t_info.button_m1)
	m_2.text = Global.op_type_to_text(t_info.button_m2_type) + str(t_info.button_m2)
	p_1.text = Global.op_type_to_text(t_info.button_p1_type) + str(t_info.button_p1)
	p_2.text = Global.op_type_to_text(t_info.button_p2_type) + str(t_info.button_p2)
	tracker_value.text = str(t_info.tracker_value)
	notes.text = t_info.tracker_notes
	
	var color_sel : Color = Global.convert_to_color(t_info.tracker_color)
	
	style_box.bg_color = color_sel
	
	values_container.add_theme_stylebox_override("panel", style_box)
	title_container.add_theme_stylebox_override("panel", style_box)
	notes_container.add_theme_stylebox_override("panel", style_box)

func _on_up_pressed() -> void:
	var parent = get_parent()
	var num_children : int = parent.get_child_count() - 2
	var location_index : int = clamp(get_index() - 1, 0, num_children)
	parent.move_child(self, location_index)

func _on_down_pressed() -> void:
	var parent = get_parent()
	var num_children : int = parent.get_child_count() - 2
	var location_index : int = clamp(get_index() + 1, 0, num_children)
	parent.move_child(self, location_index)

func change_size(font_size : int) -> void:
	tracker_name.add_theme_font_size_override("normal_font_size", font_size)
	m_1.add_theme_font_size_override("normal_font_size", font_size)
	m_2.add_theme_font_size_override("normal_font_size", font_size)
	p_1.add_theme_font_size_override("normal_font_size", font_size)
	p_2.add_theme_font_size_override("normal_font_size", font_size)
	tracker_value.add_theme_font_size_override("normal_font_size", font_size)
	notes.add_theme_font_size_override("normal_font_size", int(font_size/1.3))
