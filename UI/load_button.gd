extends HBoxContainer
class_name LoadButton

@onready var load_button: Button = $Load

func _on_load_pressed() -> void:
	Global.saver_loader.load_file(load_button.text)
	Global.load_file_request.emit(load_button.text.left(-5))

func _on_delete_pressed() -> void:
	var dir = DirAccess.open(Global.PATH_SAVE_DIRECTORY)
	if dir:
		var err = dir.remove(load_button.text)
		if err == OK:
			print("File deleted successfully.")
		else:
			print("Failed to delete file. Error code: %d" % err)
	else:
		print("Could not open directory.")
	
	self.queue_free()
