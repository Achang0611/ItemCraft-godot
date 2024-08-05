extends Control

@export
var editor: ItemEditor

@onready var looks_enchanted_check: CheckButton = $HBoxContainer/CenterContainer/LooksEnchantedCheck
@onready var hide_enchant_check: CheckButton = $HBoxContainer/CenterContainer2/HideEnchantCheck

@onready var enchantments = get_tree().get_nodes_in_group("enchantment")
var enchantment_config = {}

func _ready() -> void:
	for enchantment in enchantments:
		enchantment.update.connect(enchantment_update)

func enchantment_update(enchantment: String, value: int) -> void:
	if value == 0:
		remove_enchantment(enchantment)
	else:
		add_enchantment(enchantment, value)

func remove_enchantment(enchantment: String) -> void:
	if not enchantment_config.has("levels"):
		return
	
	enchantment_config["levels"].erase(enchantment)
	
	if enchantment_config["levels"].is_empty():
		enchantment_config.erase("levels")
		looks_enchanted_check.disabled = false
	
	update()

func add_enchantment(enchantment: String, value: int) -> void:
	looks_enchanted_check.button_pressed = false
	looks_enchanted_check.disabled = true
	if not enchantment_config.has("levels"):
		enchantment_config["levels"] = {}
	
	enchantment_config["levels"][enchantment] = value
	
	update()

func update() -> void:
	if enchantment_config.is_empty():
		editor.update_item_components("enchantments", null)
	elif enchantment_config.size() == 1 and enchantment_config.has("show_in_tooltip"):
		editor.update_item_components("enchantments", null)
	else:
		editor.update_item_components("enchantments", JSON.stringify(enchantment_config))

func _on_looks_enchanted_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		enchantment_config["levels"] = {"mending": 0}
	else:
		enchantment_config.erase("levels")
	update()

func _on_hide_enchant_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		enchantment_config["show_in_tooltip"] = false
	else:
		enchantment_config.erase("show_in_tooltip")
	update()

func clear() -> void:
	looks_enchanted_check.button_pressed = false
	hide_enchant_check.button_pressed = false
	for enchantment in enchantments:
		enchantment.set_level(0)

func _on_clear_button_pressed() -> void:
	clear()
