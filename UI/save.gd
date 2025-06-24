extends PanelContainer
class_name SavePanel

@onready var line_edit: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/LineEdit
@onready var actual_save_name: RichTextLabel = $MarginContainer/VBoxContainer/VBoxContainer/ActualSaveName

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/Title
@onready var space: RichTextLabel = $MarginContainer/VBoxContainer/space

var file_name : String

func _process(delta: float) -> void:
	if self.visible == true:
		file_name = line_edit.text.replace(" ", "_").replace(".", "").left(50)
		actual_save_name.text = file_name + ".save"

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
	Global.default_tracker = TrackerInfo.new()
	Global.load_tracker = Global.default_tracker
	Global.saver_loader.save_default_tracker()

func _on_delete_ui_save_pressed() -> void:
	Global.load_UI_size = 45
	Global.current_UI_size = 45
	Global.saved_UI_size= 4
	Global.main_menu.update_font_size(0)
	Global.saver_loader.save_UI_size()
