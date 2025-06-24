extends HBoxContainer
class_name LoadButton

@onready var load_button: Button = $Load

func _on_load_pressed() -> void:
	Global.saver_loader.load_file(load_button.text)

func _on_delete_pressed() -> void:
	self.queue_free()
	
	var dir = DirAccess.open(Global.PATH_SAVE_DIRECTORY)
	if dir:
		var err = dir.remove(load_button.text)
		if err == OK:
			print("File deleted successfully.")
		else:
			print("Failed to delete file. Error code: %d" % err)
	else:
		print("Could not open directory.")
