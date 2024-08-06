extends VBoxContainer

@export
var editor: ItemEditor

@onready var custom_name: LineEdit = $HBoxContainer/CustomName
@onready var rich_custom_name: RichTextLabel = $HBoxContainer/PanelContainer/RichCustomName
@onready var lore: TextEdit = $HBoxContainer2/Lore
@onready var rich_lore: RichTextLabel = $HBoxContainer2/ScrollContainer/PanelContainer/RichLore
@onready var text_color_preloader: ResourcePreloader = $TextColorPreloader

func format_line_color_code(line: String) -> Array[Text]:
	var parsed: Array[Text] = []
	
	var color_code_regex = RegEx.create_from_string(r"(?<!\\)(&([0-9a-f]))")
	var code_results = color_code_regex.search_all(line)
	
	var line_slices = line.split()
	var last_text = Text.new()
	var last_end = 0
	for code_result in code_results:
		last_text.text = "".join(line_slices.slice(last_end, code_result.get_start()))
		parsed.append(last_text)
		
		var color_code = code_result.get_string(2)
		var text_color = text_color_preloader.find_text_color(color_code)
		
		last_text = Text.new()
		last_text.color = text_color
		
		last_end = code_result.get_end()
	
	last_text.text = "".join(line_slices.slice(last_end))
	parsed.append(last_text)
	
	return parsed

func format_color_code(content: String) -> Array:
	var parsed: Array = []
	
	var lines = content.split("\n")
	for line in lines:
		parsed.append(format_line_color_code(line))
	
	return parsed

func content_to_rich_text(content: String) -> String:
	var rich_text = ""
	var texts = format_color_code(content)
	
	for text in texts:
		for part in text:
			rich_text += part.to_rich_text()
		rich_text += "\n"
	
	return rich_text.trim_suffix("\n")

func _on_count_value_changed(value: float) -> void:
	editor.update_item_config("count", int(value))

func _on_entity_selector_value_changed(value: String) -> void:
	editor.update_item_config("target", value)

func _on_custom_name_text_changed(new_text: String) -> void:
	rich_custom_name.text = "[center]" + content_to_rich_text(new_text)
	
	if new_text == "":
		editor.update_item_components("custom_name", null)
		return
	
	var json_custom_name = format_line_color_code(new_text)
	editor.update_item_components("custom_name", JSON.stringify(str(json_custom_name)))

func _on_lore_text_changed() -> void:
	rich_lore.text = content_to_rich_text(lore.text)
	
	if lore.text == "":
		editor.update_item_components("lore", null)
		return
	
	var json_lore = format_color_code(lore.text)
	json_lore = json_lore.map(func(text):
		return JSON.stringify(str(text))
	)
	json_lore = "[%s]" % json_lore.reduce(func(accum, text):
		return accum + text + ","
	, "").trim_suffix(",")
	editor.update_item_components("lore", json_lore)
