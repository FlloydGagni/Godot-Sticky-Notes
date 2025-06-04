extends VBoxContainer

@onready var new_note_window = preload("res://scenes/notes_card.tscn")
@onready var notes_container: VBoxContainer = $"."

func _ready() -> void:
	NotesManager.load_notes()
	load_all_notes_into_ui()

func load_all_notes_into_ui():
	for note in NotesManager.notes:
		var note_card = new_note_window.instantiate()
		note_card.initialize(note)
		get_tree().root.add_child(note_card)
