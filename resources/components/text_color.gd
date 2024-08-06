class_name TextColor
extends Resource

@export
var name: String
@export
var id: String
@export
var color: Color
@export
var color_code: String

func _to_string() -> String:
	return id
