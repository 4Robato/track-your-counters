class_name TrackerInfo
extends Node

var button_m1 : int
var button_m1_type : Global.BUTTON_TYPE
var button_m2 : int
var button_m2_type : Global.BUTTON_TYPE
var button_p1 : int
var button_p1_type : Global.BUTTON_TYPE
var button_p2 : int
var button_p2_type : Global.BUTTON_TYPE

var tracker_name : String
var tracker_value : int
var tracker_color : int
var tracker_notes : String

func _init(
	m1 : int = 1,
	m1_type : Global.BUTTON_TYPE = Global.BUTTON_TYPE.MINUS,
	m2 : int = 5,
	m2_type : Global.BUTTON_TYPE = Global.BUTTON_TYPE.MINUS,
	p1 : int = 1,
	p1_type : Global.BUTTON_TYPE = Global.BUTTON_TYPE.PLUS,
	p2 : int = 5,
	p2_type : Global.BUTTON_TYPE = Global.BUTTON_TYPE.PLUS,
	_name : String = "",
	value : int = 20,
	color : int = 0,
	notes : String = ""
) -> void:
	button_m1 = m1
	button_m1_type = m1_type
	button_m2 =  m2
	button_m2_type = m2_type
	button_p1 =  p1
	button_p1_type = p1_type
	button_p2 = p2
	button_p2_type = p2_type

	tracker_name = _name
	tracker_value = value
	tracker_color = color
	tracker_notes = notes
