extends Window

@onready var close_button : Button = $NotesCard/MainContainer/TitleBarPanelContainer/TitleBar/CloseButton
@onready var add_button : Button = $NotesCard/MainContainer/TitleBarPanelContainer/TitleBar/AddButton
@onready var new_note_window : PackedScene = preload("res://scenes/notes_card.tscn")
@onready var note_body: TextEdit = $NotesCard/MainContainer/NoteBody
@onready var debounce_timer: Timer = $NotesCard/DebounceTimer

var note_id : String
var note_data : NoteResource 
var tween : Tween = null

func _ready() -> void:
	close_button.pressed.connect(exit_notes_card)
	add_button.pressed.connect(add_new_notes)
	note_body.text_changed.connect(on_text_changed)
	debounce_timer.timeout.connect(on_save_timer_timeout)

func initialize(id : String) -> void:
	note_id = id
	note_data = NotesManager.get_note(note_id)
	$NotesCard/MainContainer/NoteBody.text = note_data.note_body

func exit_notes_card() -> void:
	if NotesManager.open_notes.has(note_id):
		NotesManager.open_notes.erase(note_id)
	queue_free()

func add_new_notes() -> void:
	var id = NotesManager.add_note()
	var note_card = new_note_window.instantiate()
	note_card.initialize(id)
	get_tree().root.add_child(note_card)

func on_text_changed() -> void:
	debounce_timer.start()

func on_save_timer_timeout() -> void:
	note_data.note_body = $NotesCard/MainContainer/NoteBody.text
	NotesManager.save_note(note_data)

func shake_and_scale() -> void :
	if tween and tween.is_running():
		tween.kill()
	
	var start_window_pos = position

	tween = create_tween()
	
	# Shake window horizontally
	tween.tween_property(self, "position:x", start_window_pos.x - 10, 0.05).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:x", start_window_pos.x + 10, 0.1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:x", start_window_pos.x, 0.05).set_trans(Tween.TRANS_SINE)
	
	
