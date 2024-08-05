class_name Enchantments
extends Resource

@export
var levels: Array[Enchantment]
@export
var show_in_tooltip: bool = true

func _to_string() -> String:
	var levels_str = "{%s}" % levels.reduce(func(accum, ench):
		return accum + "%s," % ench
	, "").trim_suffix(",")
	return "{levels:%s,show_in_tooltip:%s}" % [levels_str, show_in_tooltip]
