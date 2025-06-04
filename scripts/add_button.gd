extends Button

@onready var new_note_window = preload("res://scenes/notes_card.tscn")

func _pressed() -> void:
	var id = NotesManager.add_note()
	var note_card = new_note_window.instantiate()
	
	note_card.initialize(id)
	NotesManager.open_notes[id] = note_card
	
	get_tree().root.add_child(note_card)
