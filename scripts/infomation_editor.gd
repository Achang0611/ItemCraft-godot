extends VBoxContainer

const color_codes = preload("res://color_codes.json").data
const font_format_codes = preload("res://font_format_codes.json").data

@export
var editor: ItemEditor

@onready var custom_name: LineEdit = $HBoxContainer/CustomName
@onready var rich_custom_name: RichTextLabel = $HBoxContainer/PanelContainer/RichCustomName
@onready var lore: TextEdit = $HBoxContainer2/Lore
@onready var rich_lore: RichTextLabel = $HBoxContainer2/ScrollContainer/PanelContainer/RichLore

func parse_text(text: String) -> String:
	var processed_text = text.replace("\\&", "$TEMP$")
	
	for color in color_codes:
		processed_text = processed_text.replace(color, "[color=%s]" % color_codes[color]["hex"])
	
	processed_text = processed_text.replace("$TEMP$", "&")

	return processed_text

func _on_count_value_changed(value: float) -> void:
	editor.update_item_config("count", int(value))

func _on_entity_selector_value_changed(value: String) -> void:
	editor.update_item_config("target", value)

func _on_custom_name_text_changed(new_text: String) -> void:
	rich_custom_name.text = "[center]" + parse_text(new_text)
	
	editor.update_item_components("custom_name", JSON.stringify(JSON.stringify(new_text)))

func _on_lore_text_changed() -> void:
	rich_lore.text = parse_text(lore.text)
	
	if lore.text == "":
		editor.update_item_components("lore", null)
		return
	
	var component = Array(lore.text.split("\n"))
	component = component.map(func(i): return JSON.stringify(i))
	editor.update_item_components("lore", component)
