extends PanelContainer
class_name LogsPanel

@onready var content: RichTextLabel = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/ScrollContainer/content
@onready var scroll_container: ScrollContainer = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/ScrollContainer
@onready var title: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Title
@onready var emoji: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/Emoji

var last_log : LogTracker

func _ready() -> void:
	# We connect to the logs
	Global.add_log_tacker.connect(_add_tracker_as_text)
	Global.add_log_dice.connect(_add_text)

func _on_close_pressed() -> void:
	self.visible = false

func _add_text(text : String):
	content.append_text(text)
	Global.logs_bbcode += text

func _add_tracker_as_text(log_tracker : LogTracker):
	var text : String = convert_to_text(log_tracker)
	content.append_text(text)
	Global.logs_bbcode += text

func _on_clean_pressed() -> void:
	content.clear()
	Global.logs_bbcode = ""
	last_log = null

func convert_to_text(log_tracker : LogTracker) -> String:
	var op_text : String = Global.op_type_to_text(log_tracker.operator_type)
	var text : String = ""
	
	if last_log == null or last_log.tracker_name != log_tracker.tracker_name\
		or last_log.location != log_tracker.location or last_log.tracker_color != log_tracker.tracker_color:
		text += _add_color(" " + log_tracker.tracker_name + " (↕" + str(log_tracker.location)+ "):\n", log_tracker.tracker_color)
	
	text += "\t  " + str(log_tracker.value_pre)
	text += " (" + op_text + str(log_tracker.operator_value) + ")"
	text += " 🟰 " + str(log_tracker.value_post) + "\n"
	
	last_log = log_tracker.clone()
	return text

func _add_color(input_text: String, color: Global.COLORS) -> String:
	var color_tag: String = ""
	match color:
		Global.COLORS.BLACK: color_tag = "#000000"
		Global.COLORS.WHITE: color_tag = "#ffffff"
		Global.COLORS.YELLOW: color_tag = "#fffb6a"
		Global.COLORS.RED: color_tag = "#ff6b6f"
		Global.COLORS.BLUE: color_tag = "#6e81ff"
		Global.COLORS.CYAN: color_tag = "#6cfffb"
		Global.COLORS.GREEN: color_tag = "#6fcc78"
		Global.COLORS.BROWN: color_tag = "#b88b6c"
		Global.COLORS.ORANGE: color_tag = "#ffcc6b"
		_: color_tag = "#ffffff"
	
	return "[color=%s]%s[/color]" % [color_tag, input_text]

func on_scroll_down_pressed() -> void:
	await get_tree().process_frame
	scroll_container.call_deferred("set", "scroll_vertical", scroll_container.get_v_scroll_bar().max_value)

func _on_scroll_up_pressed() -> void:
	await get_tree().process_frame
	scroll_container.call_deferred("set", "scroll_vertical", 0)
