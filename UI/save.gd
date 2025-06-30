extends PanelContainer
class_name SavePanel

@onready var line_edit: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/LineEdit
@onready var actual_save_name: RichTextLabel = $MarginContainer/VBoxContainer/VBoxContainer/ActualSaveName

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/Title
@onready var space: RichTextLabel = $MarginContainer/VBoxContainer/space

@onready var ui_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/UIButton
@onready var delete_ui_save: Button = $MarginContainer/VBoxContainer/HBoxContainer/DeleteUISave

@onready var default_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/DefaultButton
@onready var delete_default_save: Button = $MarginContainer/VBoxContainer/HBoxContainer2/DeleteDefaultSave

var file_name : String

func _process(delta: float) -> void:
	if self.visible == true:
		file_name = line_edit.text.replace(" ", "_").replace(".", "").left(50)
		actual_save_name.text = file_name + ".save"
		
		if Global.save_file_UI_size == Global.current_UI_size:
			ui_button.disabled = true
		else:
			ui_button.disabled = false
		# delete button UI
		if Global.save_file_UI_size == Global.DEFAULT_UI_SIZE\
			and Global.current_UI_size == Global.DEFAULT_UI_SIZE:
			delete_ui_save.disabled = true
		else:
			delete_ui_save.disabled = false
		
		if _compare_trackers(Global.save_file_default_ti, Global.current_default_tracker):
			default_button.disabled = true
		else:
			default_button.disabled = false
		# delete button default tracker
		if _compare_trackers(Global.save_file_default_ti, Global.DEFAULT_TRACKER_INFO)\
			and _compare_trackers(Global.current_default_tracker, Global.DEFAULT_TRACKER_INFO):
			delete_default_save.disabled = true
		else:
			delete_default_save.disabled = false

func _compare_trackers(info_tracker_1 : TrackerInfo, info_tracker_2 : TrackerInfo) -> bool:
	if info_tracker_1.button_m1 != info_tracker_2.button_m1:
		return false
	if info_tracker_1.button_m1_type != info_tracker_2.button_m1_type:
		return false
	if info_tracker_1.button_m2 != info_tracker_2.button_m2:
		return false
	if info_tracker_1.button_m2_type != info_tracker_2.button_m2_type:
		return false
	if info_tracker_1.button_p1 != info_tracker_2.button_p1:
		return false
	if info_tracker_1.button_p1_type != info_tracker_2.button_p1_type:
		return false
	if info_tracker_1.button_p2 != info_tracker_2.button_p2:
		return false
	if info_tracker_1.button_p2_type != info_tracker_2.button_p2_type:
		return false
	
	if info_tracker_1.tracker_name != info_tracker_2.tracker_name:
		return false
	if info_tracker_1.tracker_notes != info_tracker_2.tracker_notes:
		return false
	if info_tracker_1.tracker_value != info_tracker_2.tracker_value:
		return false
	
	return true

func _on_close_pressed() -> void:
	self.visible = false

func _on_ui_button_pressed() -> void:
	Global.saver_loader.save_UI_size()

func _on_default_button_pressed() -> void:
	Global.saver_loader.save_default_tracker()

func _on_save_button_pressed() -> void:
	Global.saver_loader.save_current_trackers(file_name)
	_on_close_pressed()

func _on_delete_default_save_pressed() -> void:
	Global.current_default_tracker = TrackerInfo.new()
	Global.load_tracker = Global.current_default_tracker
	Global.saver_loader.save_default_tracker()

func _on_delete_ui_save_pressed() -> void:
	Global.load_UI_size = 45
	Global.current_UI_size = 45
	Global.main_menu.update_font_size(0)
	Global.saver_loader.save_UI_size()
