extends PanelContainer

var following : bool = false
var dragging_start_position : Vector2 = Vector2.ZERO

var window_node : Window

func _ready() -> void:
	window_node = get_parent().get_parent().get_parent() as Window

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
				following = !following
				dragging_start_position = get_local_mouse_position()

func _process(_delta: float) -> void:
	if following:
		var mouse_position = get_global_mouse_position()
		var window_position = Vector2(window_node.position)
		window_node.position = window_position + (mouse_position - dragging_start_position)
