extends HBoxContainer

@export
var editor: ItemEditor

@onready var place_blocks: VBoxContainer = $Place
@onready var break_blocks: VBoxContainer = $Break

var components = {
	"can_place_on": {},
	"can_break": {}
}

func _update() -> void:
	for key in components:
		var component = components[key]
		if component.is_empty():
			editor.update_item_components(key, null)
		elif component.size() == 1 and component.has("show_in_tooltip"):
			editor.update_item_components(key, null)
		else:
			editor.update_item_components(key, component)

func component_update(category: String, key: String, value: Variant) -> void:
	if value != null:
		components[category][key] = value
	else:
		components[category].erase(key)
	_update()

func block_update(category: String, blocks: Variant) -> void:
	if blocks.is_empty():
		component_update(category, "blocks", null)
		return
	
	var unique_blocks = []
	for block in blocks:
		if unique_blocks.has(block):
			continue
		unique_blocks.append(block)
	
	component_update(category, "blocks", unique_blocks)

func _on_place_update(blocks: Variant) -> void:
	block_update("can_place_on", blocks)

func _on_break_update(blocks: Variant) -> void:
	block_update("can_break", blocks)

func tooltip_update(category: String, toggle_on: bool) -> void:
	component_update(category, "show_in_tooltip", false if toggle_on else null)

func _on_place_toggled_tooltip(toggle_on: Variant) -> void:
	tooltip_update("can_place_on", toggle_on)

func _on_break_toggled_tooltip(toggle_on: Variant) -> void:
	tooltip_update("can_break", toggle_on)

func _on_copy_to_break_pressed() -> void:
	for block in place_blocks.blocks:
		break_blocks.add_block(block)

func _on_copy_to_place_pressed() -> void:
	for block in break_blocks.blocks:
		place_blocks.add_block(block)
