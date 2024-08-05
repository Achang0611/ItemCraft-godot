@tool
class_name NamespacedId
extends Resource

var regex = RegEx.create_from_string(r"^[0-9a-z_\-./:]+$")

@export
var id: String :
	set(value):
		if value.is_empty():
			id = str(ResourceUID.create_id())
			return
		
		var result = regex.search(value)
		if result:
			id = result.get_string()

func _init() -> void:
	id = str(ResourceUID.create_id())

func _to_string() -> String:
	if id.is_valid_int():
		return id
	else:
		return "\"%s\"" % id
