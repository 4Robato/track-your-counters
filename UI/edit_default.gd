extends PanelContainer
class_name EditPanel

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Title
@onready var emoji: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Emoji
@onready var close_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/CloseButton

@onready var edit_tracker: EditTracker = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/EditTracker

@onready var save_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/SaveButton
@onready var load_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/LoadButton
@onready var delete_button: Button = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer2/DeleteButton

@onready var scroll_container: ScrollContainer = $MarginContainer/VBoxContainer/ScrollContainer

func _ready() -> void:
	edit_tracker.name_changed.connect(_scroll_to_text_edit)
	edit_tracker.notes_changed.connect(_scroll_to_text_edit)

func _process(_delta: float) -> void:
	if self.visible:
		if Global.compare_trackers(Global.save_file_default_ti, edit_tracker.get_tracker_info()):
			save_button.disabled = true
			load_button.disabled = true
		else:
			save_button.disabled = false
			load_button.disabled = false
		if Global.compare_trackers(Global.save_file_default_ti, Global.DEFAULT_TRACKER_INFO):
			delete_button.disabled = true
		else:
			delete_button.disabled = false

func _scroll_to_text_edit(text_edit : TextEdit) -> void:
	scroll_container.ensure_control_visible(text_edit)

func _on_save_button_pressed() -> void:
	_on_accept_button_pressed()
	Global.saver_loader.save_default_tracker()

func _on_load_button_pressed() -> void:
	edit_tracker.set_values(Global.load_tracker)

func _on_delete_button_pressed() -> void:
	Global.current_default_tracker = TrackerInfo.new()
	Global.load_tracker = Global.current_default_tracker
	Global.saver_loader.save_default_tracker()
	edit_tracker.set_values(Global.current_default_tracker)

func _on_accept_button_pressed() -> void:
	self.visible = false
	var new_default : TrackerInfo = edit_tracker.get_tracker_info()
	Global.current_default_tracker = new_default

func _on_cancel_button_pressed() -> void:
	self.visible = false
	edit_tracker.set_values(Global.current_default_tracker)

func _on_close_button_pressed() -> void:
	self.visible = false
	edit_tracker.set_values(Global.current_default_tracker)
