class_name Slot
extends Resource

@export
var name: String
@export
var id: String
@export
var equivalent: Array[Slot]

func _to_string() -> String:
	return id
