extends PanelContainer
class_name SavePanel

@onready var line_edit: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/LineEdit
@onready var actual_save_name: RichTextLabel = $MarginContainer/VBoxContainer/VBoxContainer/ActualSaveName

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/Title
@onready var space: RichTextLabel = $MarginContainer/VBoxContainer/space

@onready var ui_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/UIButton
@onready var delete_ui_save: Button = $MarginContainer/VBoxContainer/HBoxContainer/DeleteUISave

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
		

func _on_close_pressed() -> void:
	self.visible = false

func _on_ui_button_pressed() -> void:
	Global.saver_loader.save_UI_size()

func _on_save_button_pressed() -> void:
	Global.saver_loader.save_current_trackers(file_name)
	_on_close_pressed()

func _on_delete_ui_save_pressed() -> void:
	Global.load_UI_size = 45
	Global.current_UI_size = 45
	Global.main_menu.update_font_size(0)
	Global.saver_loader.save_UI_size()
