extends PanelContainer
class_name TrackerManager

const MANAGE_TRACKER = preload("uid://dw33k58lt26fk")
@onready var trackers: VBoxContainer = $MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/Trackers
@onready var add_button: Button = $MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/Trackers/AddButton

@onready var emoji: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Emoji
@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Title

func _ready() -> void:
	Global.saver_loader.load_custom_trackers()

func _on_close_button_pressed() -> void:
	self.visible = false

func _on_add_button_pressed() -> void:
	var tracker : PreviewTracker = MANAGE_TRACKER.instantiate()
	
	trackers.add_child(tracker)
	
	add_button.reparent(self)
	add_button.reparent(trackers)

func _on_save_button_pressed() -> void:
	Global.saver_loader.save_custom_trackers()
	self.visible = false

func add_custom_tracker(tracker_info : TrackerInfo) -> void:
	var tracker : PreviewTracker = MANAGE_TRACKER.instantiate()
	
	trackers.add_child(tracker)
	tracker.set_values(tracker_info)
	
	add_button.reparent(self)
	add_button.reparent(trackers)

func delete_all_trackers() -> void:
	for item in trackers.get_children():
		if item is PreviewTracker:
			item.queue_free()

func _on_discard_button_pressed() -> void:
	Global.saver_loader.load_custom_trackers()
