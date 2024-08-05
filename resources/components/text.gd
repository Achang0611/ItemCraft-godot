class_name Text
extends Resource

@export
var text: String
@export
var color: TextColor
@export
var bold: bool = false
@export
var italic: bool = true
@export
var underlined: bool = false
@export
var strikethrough: bool = false
@export
var obfuscated: bool = false

func _to_string() -> String:
	return "{text:%s,color:%s,bold:%s,italic:%s,underlined:%s,strikethrough:%s,obfuscated:%s}" \
	% [text, color, bold, italic, underlined, strikethrough, obfuscated]
