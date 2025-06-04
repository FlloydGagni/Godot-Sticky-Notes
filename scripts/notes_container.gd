extends VBoxContainer

@onready var new_note_window = preload("res://scenes/notes_card.tscn")
@onready var notes_container: VBoxContainer = $"."
@onready var note_preview = preload("res://scenes/note_preview.tscn")

func _ready() -> void:
	NotesManager.load_notes()
	load_all_notes_into_ui()
	
	SignalBus.notes_saved.connect(load_all_notes_into_ui)

func load_all_notes_into_ui():
	for child in notes_container.get_children():
		child.queue_free()
	
	for note in NotesManager.notes:
		var preview_instance = note_preview.instantiate()
		var preview_label: RichTextLabel = preview_instance.get_node("PreviewMarginContainer/PreviewText")
		
		preview_instance.preview_note_id = note
		preview_label.text = NotesManager.notes[note].note_body
		
		notes_container.add_child.call_deferred(preview_instance)
