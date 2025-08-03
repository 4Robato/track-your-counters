class_name ButtonModifier
extends Button


@export var value : int :
	get:
		return value
	set(val):
		value = val
		_change_text()

@export var type : OperatorButton.BUTTON_TYPE :
	get:
		return type
	set(val):
		type = val
		_ready()

func _ready() -> void:
	_change_text()

func _change_text():
	match type:
		OperatorButton.BUTTON_TYPE.PLUS:
			text = "➕ "
		OperatorButton.BUTTON_TYPE.MINUS:
			text = "➖ "
		OperatorButton.BUTTON_TYPE.MULTIPLY:
			text = "✖ "
		OperatorButton.BUTTON_TYPE.DIVIDE:
			text = "➗ "
		OperatorButton.BUTTON_TYPE.HAND:
			text = "✍ "
		_:
			text = "➕ "
	text += str(value)
