extends Button

@onready var new_note_window = preload("res://scenes/notes_card.tscn")

func _pressed() -> void:
	get_tree().root.add_child(new_note_window.instantiate())
