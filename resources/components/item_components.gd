class_name ItemComponents
extends Resource

@export
var attribute_modifiers: AttributeModifiers
@export
var enchantments: Enchantments

func _to_string() -> String:
	return "[attribute_modifiers=%s,enchantments=%s]" % [attribute_modifiers, enchantments]
