extends Node
class_name SaverLoader

const SETTINGS_PATH : String = Global.PATH_SETTINGS + "settings.save"
const SAVE_PATH : String = Global.PATH_SAVE_DIRECTORY

func save_UI_size():
	var file = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var saved_data : Dictionary[String, Variant] = Global.load_tracker.get_dict()
	
	saved_data["ui_size"] = Global.current_UI_size
	Global.save_file_UI_size = Global.current_UI_size
	
	var json_string = JSON.stringify(saved_data)
	file.store_line(json_string)
	file.close()

func save_default_tracker():
	var file = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var saved_data : Dictionary[String, Variant] = Global.current_default_tracker.get_dict()
	
	saved_data["ui_size"] = Global.load_UI_size
	
	Global.load_tracker = Global.current_default_tracker
	Global.save_file_default_ti = Global.current_default_tracker
	
	var json_string = JSON.stringify(saved_data)
	file.store_line(json_string)
	file.close()

func save_custom_tracker_as_default(cust_tracker : TrackerInfo):
	var file = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var saved_data : Dictionary[String, Variant] = cust_tracker.get_dict()
	
	saved_data["ui_size"] = Global.load_UI_size
	
	Global.load_tracker = cust_tracker
	Global.save_file_default_ti = cust_tracker
	
	var json_string = JSON.stringify(saved_data)
	file.store_line(json_string)
	file.close()

func load_settings():
	if not FileAccess.file_exists(SETTINGS_PATH):
		return # Error! We don't have a save to load.
	
	var save_file = FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		# Creates the helper class to interact with JSON.
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		# Get the data from the JSON object.
		var node_data : Dictionary = json.data
		
		Global.current_UI_size = node_data["ui_size"]
		Global.load_UI_size = node_data["ui_size"]
		Global.save_file_UI_size = node_data["ui_size"]
		
		var default_tracker : TrackerInfo = TrackerInfo.new(
			node_data["m1"],
			node_data["m1_type"],
			node_data["m2"],
			node_data["m2_type"],
			node_data["p1"],
			node_data["p1_type"],
			node_data["p2"],
			node_data["p2_type"],
			node_data["name"],
			node_data["value"],
			node_data["color"],
			node_data["notes"],
			node_data["is_minimized"],
			node_data["is_show_note"]
		)
		Global.current_default_tracker = default_tracker
		Global.load_tracker = default_tracker
		Global.save_file_default_ti = default_tracker

func load_def_tracker() -> void:
	if not FileAccess.file_exists(SETTINGS_PATH):
		return # Error! We don't have a save to load.
	
	var save_file = FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		# Creates the helper class to interact with JSON.
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		# Get the data from the JSON object.
		var node_data : Dictionary = json.data
		
		var default_tracker : TrackerInfo = TrackerInfo.new(
			node_data["m1"],
			node_data["m1_type"],
			node_data["m2"],
			node_data["m2_type"],
			node_data["p1"],
			node_data["p1_type"],
			node_data["p2"],
			node_data["p2_type"],
			node_data["name"],
			node_data["value"],
			node_data["color"],
			node_data["notes"],
			node_data["is_minimized"],
			node_data["is_show_note"]
		)
		Global.current_default_tracker = default_tracker
		Global.load_tracker = default_tracker
		Global.save_file_default_ti = default_tracker

func save_current_trackers(file_name : String):
	if file_name == "":
		return
	
	var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	
	#create folder if not exists:
	var dir = DirAccess.open(SAVE_PATH)
	if dir == null:
		var _error = DirAccess.make_dir_recursive_absolute(SAVE_PATH)
	
	var file = FileAccess.open(SAVE_PATH + file_name + ".save", FileAccess.WRITE)
	var all_trackers : Array[Dictionary]
	var saved_data : Dictionary[String, Variant] = {}
	
	for item in Global.main_menu.v_box_container.get_children():
		if item is Tracker:
			all_trackers.append(item.get_tracker_info().get_dict())
	
	var default_dict : Dictionary[String, Variant] = Global.current_default_tracker.get_dict()
	for key in default_dict:
		saved_data[key + "_default"] = default_dict[key]
	
	saved_data["num_trackers"] = len(all_trackers)
	
	for i in range(len(all_trackers)):
		for key in all_trackers[i]:
			var num_id : String = str(i).pad_zeros(4)
			saved_data[key + "_" + num_id] = all_trackers[i][key]
	
	var json_string = JSON.stringify(saved_data)
	file.store_line(json_string)
	file.close()

func load_file(file_name : String) -> void:
	if not FileAccess.file_exists(SAVE_PATH + file_name):
		return # Error! We don't have a save to load.
	
	var save_file = FileAccess.open(SAVE_PATH + file_name, FileAccess.READ)
	
	Global.main_menu._delete_all_trackers()
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		# Creates the helper class to interact with JSON.
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		# Get the data from the JSON object.
		var node_data : Dictionary = json.data
		
		var default_tracker : TrackerInfo = TrackerInfo.new(
			node_data["m1_default"],
			node_data["m1_type_default"],
			node_data["m2_default"],
			node_data["m2_type_default"],
			node_data["p1_default"],
			node_data["p1_type_default"],
			node_data["p2_default"],
			node_data["p2_type_default"],
			node_data["name_default"],
			node_data["value_default"],
			node_data["color_default"],
			node_data["notes_default"],
			node_data["is_minimized_default"],
			node_data["is_show_note_default"]
		)
		Global.current_default_tracker = default_tracker
		Global.load_tracker = default_tracker
		
		var num_trackers : int = node_data["num_trackers"]
		for i in num_trackers:
			var num_id : String = str(i).pad_zeros(4)
			
			var tracker : TrackerInfo = TrackerInfo.new(
				node_data["m1_" + num_id],
				node_data["m1_type_" + num_id],
				node_data["m2_" + num_id],
				node_data["m2_type_" + num_id],
				node_data["p1_" + num_id],
				node_data["p1_type_" + num_id],
				node_data["p2_" + num_id],
				node_data["p2_type_" + num_id],
				node_data["name_" + num_id],
				node_data["value_" + num_id],
				node_data["color_" + num_id],
				node_data["notes_" + num_id],
				node_data["is_minimized_" + num_id],
				node_data["is_show_note_" + num_id]
			)
			
			Global.main_menu.add_tracker(tracker)
	Global.main_menu.load_panel.visible = false
