class_name ModifierType
extends Resource

@export
var name: String
@export
var id: String
@export
var description: String
@export
var category: String
@export
var min: float
@export
var max: float

func _to_string() -> String:
	return id
