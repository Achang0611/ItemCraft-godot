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

func to_rich_text() -> String:
	var rich_text = text
	if color != null:
		rich_text = "[color=%s]%s[/color]" % [color.color.to_html(false), rich_text]
	if bold:
		rich_text = "[b]%s[/b]" % rich_text
	if italic:
		rich_text = "[i]%s[/i]" % rich_text
	if underlined:
		rich_text = "[u]%s[/u]" % rich_text
	if strikethrough:
		rich_text = "[s]%s[/s]" % rich_text
	
	return rich_text

func _to_string() -> String:
	return "{text:\"%s\",color:%s,bold:%s,italic:%s,underlined:%s,strikethrough:%s,obfuscated:%s}" \
	% [text, color if color != null else "white", bold, italic, underlined, strikethrough, obfuscated]
