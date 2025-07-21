class_name TrackerInfo
extends Node

var TRACKER = preload("res://UI/tracker.tscn")

var button_m1 : int
var button_m1_type : OperatorButton.BUTTON_TYPE
var button_m2 : int
var button_m2_type : OperatorButton.BUTTON_TYPE
var button_p1 : int
var button_p1_type : OperatorButton.BUTTON_TYPE
var button_p2 : int
var button_p2_type : OperatorButton.BUTTON_TYPE

var tracker_name : String
var tracker_value : int
var tracker_color : Global.COLORS
var tracker_notes : String
var is_minimized : bool = false
var is_show_note : bool = false

func _init(
	m1 : int = 1,
	m1_type : OperatorButton.BUTTON_TYPE = OperatorButton.BUTTON_TYPE.MINUS,
	m2 : int = 5,
	m2_type : OperatorButton.BUTTON_TYPE = OperatorButton.BUTTON_TYPE.MINUS,
	p1 : int = 1,
	p1_type : OperatorButton.BUTTON_TYPE = OperatorButton.BUTTON_TYPE.PLUS,
	p2 : int = 5,
	p2_type : OperatorButton.BUTTON_TYPE = OperatorButton.BUTTON_TYPE.PLUS,
	_name : String = "",
	value : int = 20,
	color : Global.COLORS = Global.COLORS.BLACK,
	notes : String = "",
	minimized : bool = false,
	show_note : bool = false
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
	is_minimized = minimized
	is_show_note = show_note

func get_tracker() -> Tracker:
	var tracker : Tracker = TRACKER.instantiate()
	tracker.t_info = self
	return tracker

func get_dict() -> Dictionary[String, Variant]:
	var dict : Dictionary[String, Variant]
	
	dict["m1"] = button_m1
	dict["m1_type"] = button_m1_type
	dict["m2"] = button_m2
	dict["m2_type"] = button_m2_type
	dict["p1"] = button_p1
	dict["p1_type"] = button_p1_type
	dict["p2"] = button_p2
	dict["p2_type"] = button_p2_type
	dict["name"] = tracker_name
	dict["value"] = tracker_value
	dict["color"] = tracker_color
	dict["notes"] = tracker_notes
	dict["is_minimized"] = is_minimized
	dict["is_show_note"] = is_show_note
	
	return dict

func clone() -> TrackerInfo:
	var info : TrackerInfo = TrackerInfo.new(
		button_m1,
		button_m1_type,
		button_m2,
		button_m2_type,
		button_p1,
		button_p1_type,
		button_p2,
		button_p2_type,
		tracker_name,
		tracker_value,
		tracker_color,
		tracker_notes,
		is_minimized,
		is_show_note
	)
	return info
