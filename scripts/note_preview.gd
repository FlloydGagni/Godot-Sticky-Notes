extends PanelContainer

@export var preview_note_id : String

@onready var new_note_window = preload("res://scenes/notes_card.tscn")

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				
				if NotesManager.open_notes.has(preview_note_id):
					var exisisting_window = NotesManager.open_notes[preview_note_id] as Window
					
					if is_instance_valid(exisisting_window):
						exisisting_window.shake_and_scale()
						return
					else:
						NotesManager.open_notes.erase(preview_note_id)
				
				var note_card = new_note_window.instantiate()
				note_card.initialize(preview_note_id)
				
				NotesManager.open_notes[preview_note_id] = note_card
				
				get_tree().root.add_child.call_deferred(note_card)
