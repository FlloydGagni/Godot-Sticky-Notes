extends Window

@onready var close_button = $NotesCard/MainContainer/TitleBarPanelContainer/TitleBar/CloseButton
@onready var add_button = $NotesCard/MainContainer/TitleBarPanelContainer/TitleBar/AddButton
@onready var new_note_window = preload("res://scenes/notes_card.tscn")

func _ready() -> void:
	close_button.pressed.connect(exit_notes_card)
	add_button.pressed.connect(add_new_notes)

func exit_notes_card() -> void:
	queue_free()

func add_new_notes() -> void:
	get_tree().root.add_child(new_note_window.instantiate())
