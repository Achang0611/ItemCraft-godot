class_name ItemEditor
extends Control

@onready var item_selector: PanelContainer = $ItemSelector
@onready var item_button: Button = $ItemEdit/PanelContainer/MarginContainer/ItemButton
@onready var item_edit: VBoxContainer = $ItemEdit
@onready var command_text: TextEdit = $ItemEdit/CommandText

var item_config = {
	"target": "@p",
	"item": "cobblestone",
	"count": "1",
}
var item_components = {}

func update_item_components(key, value):
	if value:
		item_components[key] = value
	else:
		item_components.erase(key)
	
	generate_command()

func update_item_config(key, value):
	if value:
		item_config[key] = value
	else:
		item_config.erase(key)
		
	generate_command()

func generate_command():
	if item_components.is_empty():
		item_config["components"] = ""
	else:
		var component_str = "["
		for component_key in item_components:
			var component = item_components[component_key]
			component_str = "%s%s=%s," % [component_str, component_key, component]
		component_str = "%s]" % component_str.trim_suffix(",")
		item_config["components"] = component_str
	
	var command = "/give {target} {item}{components} {count}".format(item_config)
	
	command_text.text = command

func select(item: Item):
	item_button.icon = item.texture
	update_item_config("item", item.id)
	item_selector.visible = false
	item_edit.visible = true

@export
var test: ItemComponents

func _ready() -> void:
	generate_command()

func _on_change_item_pressed() -> void:
	item_selector.visible = true
	item_edit.visible = false
