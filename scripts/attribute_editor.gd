extends VBoxContainer

@export
var editor: ItemEditor

const attribute_modifier = preload("res://scenes/attribute_modifier.tscn")

@onready var attribute_modifiers: VBoxContainer = $ScrollContainer/AttributeModifiers

var all_modifiers = {}
var component = {}
var show_in_tooltip = true

func update() -> void:
	if component.is_empty():
		editor.update_item_components("attribute_modifiers", null)
	elif component.size() == 1 and component.has("show_in_tooltip"):
		editor.update_item_components("attribute_modifiers", null)
	else:
		editor.update_item_components("attribute_modifiers", JSON.stringify(component))

func child_update(id, components):
	if components == null:
		all_modifiers.erase(id)
	else:
		all_modifiers[id] = components
	
	if all_modifiers.is_empty():
		component.erase("modifiers")
		update()
		return
	
	var modifiers = []
	for modifier in all_modifiers:
		modifiers.append_array(all_modifiers[modifier])
		
	component["modifiers"] = modifiers
	update()

func _on_add_modifier_pressed() -> void:
	var modifier = attribute_modifier.instantiate()
	var separator = HSeparator.new()
	var id = modifier.attribute_modifier["id"]
	while all_modifiers.has(id):
		modifier.generate_id()
		id = modifier.attribute_modifier["id"]
	
	modifier.update.connect(func(components):
		child_update(id, components)
	)
	modifier.tree_exited.connect(func():
		child_update(id, null)
		separator.queue_free()
	)
	attribute_modifiers.add_child(modifier)
	attribute_modifiers.add_child(separator)

func _on_hide_attribute_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		component["show_in_tooltip"] = false
	else:
		component.erase("show_in_tooltip")
	update()

func _on_clear_button_pressed() -> void:
	attribute_modifiers.get_children().map(func(node): node.queue_free())
