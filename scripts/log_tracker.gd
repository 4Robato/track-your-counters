extends Node
class_name LogTracker

var tracker_name : String :
	get:
		return tracker_name
	set(value):
		if value == null:
			tracker_name = ""
		else:
			tracker_name = value
var location : int
var value_pre : int
var value_post : int
var operator_type : OperatorButton.BUTTON_TYPE
var operator_value : int
var tracker_color : Global.COLORS

func clone():
	var logt = LogTracker.new()
	logt.tracker_name = tracker_name
	logt.location = location
	logt.value_pre = value_pre
	logt.value_post = value_post
	logt.operator_type = operator_type
	logt.operator_value = operator_value
	logt.tracker_color = tracker_color
	return logt
