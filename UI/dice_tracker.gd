extends MarginContainer
class_name DiceTracker

@onready var delete: Button = $HBoxContainer/Delete
@onready var roll: Button = $HBoxContainer/Roll
@onready var dice_amount: SpinBox = $HBoxContainer/DiceAmount
@onready var dice_type: MenuButton = $HBoxContainer/dice_type
@onready var result: Button = $HBoxContainer/result

func _ready() -> void:
	var line_edit : LineEdit = dice_amount.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	
	# This is so the current dice is shown
	var dice_popup := dice_type.get_popup()
	dice_popup.id_pressed.connect(on_dice_selected)
	
	dice_popup.set_focused_item(2)
	on_dice_selected(2)

func _on_result_pressed() -> void:
	result.text = ""

func _on_delete_pressed() -> void:
	queue_free()

func _on_roll_pressed() -> void:
	var dice_res : int = 0
	
	match dice_type.text:
		"D2":# D2
			for i in dice_amount.value:
				dice_res += randi_range(0, 1)
		"D4":# D4
			for i in dice_amount.value:
				dice_res += randi_range(1, 4)
		"D6":# D6
			for i in dice_amount.value:
				dice_res += randi_range(1, 6)
		"D10":# D10
			for i in dice_amount.value:
				dice_res += randi_range(0, 9)
		"D12":# D12
			for i in dice_amount.value:
				dice_res += randi_range(1, 12)
		"D20":# D20
			for i in dice_amount.value:
				dice_res += randi_range(1, 20)
		_:
			dice_res = -1
	result.text = str(dice_res)
	
	var log_text : String = "🎲 " + dice_type.text + " (x" + str(int(dice_amount.value)) + ")"+ ": " + str(dice_res) + "\n"
	_log_dice(log_text)

func on_dice_selected(id : int) -> void:
	dice_type.text = dice_type.get_popup().get_item_text(id)
	return

func set_UI_size():
	dice_type.add_theme_font_size_override("font_size", Global.current_UI_size)
	var dice_items : PopupMenu = dice_type.get_popup()
	dice_items.add_theme_font_size_override("font_size", Global.current_UI_size)
	
	# for spinbox we edit the internal linedit
	var dice_line_edit : LineEdit = dice_amount.get_line_edit()
	dice_line_edit.add_theme_font_size_override("font_size", Global.current_UI_size)
	dice_line_edit.add_theme_constant_override("minimum_character_width", 1)

func _log_dice(text : String) -> void:
	Global.add_log_dice.emit(text)
