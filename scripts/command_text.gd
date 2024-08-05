extends TextEdit

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		copy()
