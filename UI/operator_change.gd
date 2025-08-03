extends Button
class_name OperatorButton

enum BUTTON_TYPE {
	PLUS,
	MINUS,
	MULTIPLY,
	DIVIDE,
	HAND
}

@export var operator_type : BUTTON_TYPE = BUTTON_TYPE.PLUS :
	get:
		return operator_type
	set(value):
		operator_type = value
		_set_button_text()
		
@onready var button_line_editm_1: Button = $"."

func _ready() -> void:
	_set_button_text()

func _on_pressed() -> void:
	match operator_type:
		BUTTON_TYPE.MINUS:
			operator_type = BUTTON_TYPE.PLUS
		BUTTON_TYPE.PLUS:
			operator_type = BUTTON_TYPE.MULTIPLY
		BUTTON_TYPE.MULTIPLY:
			operator_type = BUTTON_TYPE.DIVIDE
		BUTTON_TYPE.DIVIDE:
			operator_type = BUTTON_TYPE.MINUS
		_:
			operator_type = BUTTON_TYPE.PLUS

func _set_button_text() -> void:
	match operator_type:
		BUTTON_TYPE.PLUS:
			self.text = "  ➕  "
		BUTTON_TYPE.MINUS:
			self.text = "  ➖  "
		BUTTON_TYPE.MULTIPLY:
			self.text = "  ✖  "
		BUTTON_TYPE.DIVIDE:
			self.text = "  ➗  "
		_:
			self.text = "  ➕  "
