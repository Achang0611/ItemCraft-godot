class_name AttributeModifiers
extends Resource

@export
var modifiers: Array[Modifier] = []
@export
var show_in_tooltip: bool = true

func _to_string() -> String:
	return "{modifiers:%s,show_in_tooltip:%s}" % [modifiers, show_in_tooltip]
