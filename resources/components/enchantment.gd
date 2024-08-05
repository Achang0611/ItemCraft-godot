class_name Enchantment
extends Resource

@export
var name: String
@export
var id: String
@export_range(0, 255)
var level: int
@export
var description: String
@export
var category: String
@export
var max_level: int

func _to_string() -> String:
	return "%s:%s" % [id, level]
