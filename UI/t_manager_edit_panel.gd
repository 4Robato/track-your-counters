extends PanelContainer

@onready var edit_tracker: EditTracker = $MarginContainer/VBoxContainer/ScrollContainer/EditTracker

var t_info : TrackerInfo :
	get:
		return t_info
	set(value):
		t_info = value
		edit_tracker.set_values(value)

var prev_tracker : PreviewTracker

func _ready() -> void:
	Global.edit_custom_tracker.connect(_setup)

func _on_accept_button_pressed() -> void:
	visible = false
	var track_info : TrackerInfo = edit_tracker.get_tracker_info()
	prev_tracker.set_values(track_info)

func _on_cancel_button_pressed() -> void:
	visible = false

func _setup(preview_tracker : PreviewTracker) -> void:
	self.visible = true
	t_info = preview_tracker.t_info
	prev_tracker = preview_tracker
