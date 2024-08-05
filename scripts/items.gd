extends ResourcePreloader

var suffix = ".png"
var item_img_dir = "res://items_1.21/"
var items = {}

func get_item_name(id: String) -> String:
	return id.capitalize()

func get_items() -> PackedStringArray:
	return get_resource_list()

func get_item_textures() -> Array[Texture2D]:
	return resources

func get_item_texture(id: String) -> Texture2D:
	return get_resource(id)
