extends Node

var notes : Dictionary = {}

func add_note(body : String = "") -> String:
	var id = _generate_id()
	var note = NoteResource.new()
	
	note.note_id = id
	note.note_body = body
	
	notes[id] = note
	
	return id

func delete_note(id : String) -> void:
	notes.erase(id)

func get_note(id : String) -> NoteResource:
	return notes.get(id)

func _generate_id() -> String:
	return str(Time.get_unix_time_from_system())

func save_note(note : NoteResource) -> void :
	var dir = DirAccess.open("user://")
	
	if not dir.dir_exists("notes"):
		dir.make_dir("notes")
	
	ResourceSaver.save(note, "user://notes/%s.tres" % note.note_id)

func load_notes():
	var dir = DirAccess.open("user://notes")
	
	if dir == null:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var note_resource : NoteResource = load("user://notes/" + file_name)
			if note_resource:
				notes[note_resource.note_id] = note_resource
		file_name = dir.get_next()
	dir.list_dir_end()
