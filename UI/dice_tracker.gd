extends MarginContainer
class_name DiceTracker

@onready var delete: Button = $VBoxContainer/HBoxContainer/Delete
@onready var roll: Button = $VBoxContainer/HBoxContainer/Roll
@onready var dice_amount: SpinBox = $VBoxContainer/HBoxContainer/DiceAmount
@onready var dice_type: MenuButton = $VBoxContainer/HBoxContainer/dice_type
@onready var result: Button = $VBoxContainer/HBoxContainer/result
@onready var dice_results: Button = $VBoxContainer/DiceResults

var dice_results_str : String = " "

func _ready() -> void:
	var line_edit : LineEdit = dice_amount.get_line_edit()
	line_edit.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER
	
	# This is so the current dice is shown
	var dice_popup := dice_type.get_popup()
	dice_popup.id_pressed.connect(on_dice_selected)
	
	dice_popup.set_focused_item(2)
	on_dice_selected(2)

func _on_result_pressed() -> void:
	if result.text == "⤵":
		result.text = "⤴"
		dice_results.visible = true
		dice_results_str = " "
	elif result.text == "⤴" or dice_amount.value > 1:
		result.text = "⤵"
		dice_results.text = " "
		dice_results.visible = false
	else:
		result.text = ""

func _on_delete_pressed() -> void:
	queue_free()

func _on_roll_pressed() -> void:
	var dice_res : int = 0
	var sum_res : int = 0
	
	dice_results_str = "("
	match dice_type.text:
		"D2":# D2
			for i in dice_amount.value:
				dice_res = randi_range(0, 1)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		"D4":# D4
			for i in dice_amount.value:
				dice_res = randi_range(1, 4)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		"D6":# D6
			for i in dice_amount.value:
				dice_res = randi_range(1, 6)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		"D10":# D10
			for i in dice_amount.value:
				dice_res = randi_range(0, 9)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		"D12":# D12
			for i in dice_amount.value:
				dice_res = randi_range(1, 12)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		"D20":# D20
			for i in dice_amount.value:
				dice_res = randi_range(1, 20)
				sum_res += dice_res
				dice_results_str += str(dice_res) + ", "
		_:
			dice_res = -1
			sum_res = -1
	
	dice_results_str = dice_results_str.left(dice_results_str.length() - 2) + ")"
	
	if dice_results.visible:
		result.text = "⤴"
	else:
		result.text = str(sum_res)
	dice_results.text = dice_results_str + " = " + str(sum_res)
	
	var log_text : String = "🎲 " + dice_type.text + " (x" + str(int(dice_amount.value)) + ")"
	log_text += ": " + str(sum_res)
	if dice_amount.value > 1:
		log_text += "   ▶   " + dice_results_str
	
	log_text += "\n"
	_log_dice(log_text)

func on_dice_selected(id : int) -> void:
	dice_type.text = dice_type.get_popup().get_item_text(id)

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

func _on_dice_results_pressed() -> void:
	dice_results.text = " "

func _on_dice_amount_value_changed(value: float) -> void:
	if value == 1 and result.text == "⤵":
		result.text = ""
	elif dice_results.visible:
		result.text = "⤴"
	else:
		result.text = "⤵"
		dice_results.text = " "
		
