extends Control

const enchantments = preload("res://enchantments_1.21.json").data

@onready var all_categorys_template: VBoxContainer = $AllCategorysTemplate
@onready var enchantment_template: PanelContainer = $AllCategorysTemplate/CategoryTemplate/Enchantments/EnchantmentTemplate
@onready var all_categorys: VBoxContainer = $AllCategorys

var categorys = {}

func add_enchantment(category: String, node: Node) -> void:
	if not categorys.has(category):
		categorys[category] = []
	
	categorys[category].append(node)

func load_enchantment() -> void:
	for enchantment in enchantments:
		var node = enchantment_template.duplicate()
		node.name = enchantment["name"]
		var label = node.get_node("MarginContainer/VBoxContainer/Label")
		label.text = enchantment["name"]
		var spin_box = node.get_node("MarginContainer/VBoxContainer/SpinBox")
		spin_box.suffix = "/ %s" % enchantment["max_level"]
		node.add_to_group("enchantment", true)
		
		add_enchantment(enchantment["category"], node)

func struct_category() -> void:
	var keys = categorys.keys()
	keys.sort()
	
	for category in keys:
		for enchantment in categorys[category]:
			all_categorys.add_enchantment(category, enchantment)

func _ready() -> void:
	load_enchantment()
	struct_category()
	all_categorys_template.queue_free()
