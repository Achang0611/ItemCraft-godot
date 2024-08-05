extends OptionButton

signal value_changed(value: String)

@onready var player_name: LineEdit = $"../PlayerName"

func _on_item_selected(index: int) -> void:
	if index == 6:
		player_name.editable = true
		value_changed.emit("Achang_0611")
	else:
		value_changed.emit(text)

func _on_player_name_text_changed(new_text: String) -> void:
	if new_text == "":
		value_changed.emit("Achang_0611")
	else:
		value_changed.emit(new_text)


func _on_player_name_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		select(6)
		item_selected.emit(6)
