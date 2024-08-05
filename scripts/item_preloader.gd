extends ResourcePreloader

func get_items() -> Array[Item]:
	var output: Array[Item] = []
	output.assign(resources[1])
	return output

func get_item(id: String) -> Item:
	return get_resource(id)

