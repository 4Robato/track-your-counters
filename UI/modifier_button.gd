class_name ButtonModifier
extends Button


@export var value : int :
	get:
		return value
	set(val):
		value = val
		_change_text()
		
@export var type : Global.BUTTON_TYPE :
	get:
		return type
	set(val):
		type = val
		_ready()

# used when editing so if you cancel it doesn't populate the true value
var type_edit : Global.BUTTON_TYPE

func _ready() -> void:
	_change_text()
	#to aboid initialization issues:
	type_edit = type

func _change_text():
	match type:
		Global.BUTTON_TYPE.PLUS:
			text = "+ "
		Global.BUTTON_TYPE.MINUS:
			text = "- "
		Global.BUTTON_TYPE.MULTIPLY:
			text = "x "
		Global.BUTTON_TYPE.DIVIDE:
			text = "÷ "
		_:
			text = "+ "
	text += str(value)
