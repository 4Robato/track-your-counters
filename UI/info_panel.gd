extends PanelContainer

@onready var title: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/HBoxContainer/Title
@onready var content: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/PanelContainer/MarginContainer/content
@onready var emoji: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/HBoxContainer/Emoji
@onready var current_version: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/HBoxContainer/version

func _ready() -> void:
	var cur_version : String = str(ProjectSettings.get_setting("application/config/version"))
	current_version.text = "(v" + cur_version + ") "

func _on_close_pressed() -> void:
	self.visible = false
