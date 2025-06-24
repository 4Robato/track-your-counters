extends PanelContainer

@onready var title: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/HBoxContainer/Title
@onready var content: RichTextLabel = $MarginContainer/ScrollContainer/VBoxContainer/PanelContainer/MarginContainer/content

func _on_close_pressed() -> void:
	self.visible = false
