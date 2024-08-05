extends Control

signal update(modifiers)

@onready var id: LineEdit = $MarginContainer/HBoxContainer/VBoxContainer/Id
@onready var type: OptionButton = $MarginContainer/HBoxContainer/VBoxContainer/Type
@onready var operation: OptionButton = $MarginContainer/HBoxContainer/VBoxContainer/Operation
@onready var amount: SpinBox = $MarginContainer/HBoxContainer/VBoxContainer/Amount

const attributes = preload("res://attributes_1.21.json").data
const operations = preload("res://operations.json").data

var rng = RandomNumberGenerator.new()
var slots = []
var attribute_modifier = Components.attribute_modifier()

func _init() -> void:
	generate_id()
	attribute_modifier.erase("slot")

func generate_id() -> void:
	attribute_modifier["id"] = ResourceUID.create_id()

func _ready() -> void:
	_update()

func _update() -> void:
	if slots.is_empty():
		update.emit([attribute_modifier])
		return
	
	var modifiers = []
	for slot in slots:
		var modifier = attribute_modifier.duplicate()
		modifier["slot"] = slot
		modifiers.append(modifier)
	update.emit(modifiers)

func _on_on_slots_update(slots) -> void:
	self.slots = slots
	_update()

func _on_delete_pressed() -> void:
	queue_free()

func _on_id_text_changed(new_text: String) -> void:
	if new_text == "":
		generate_id()
	else:
		attribute_modifier["id"] = new_text
	_update()

func _on_type_item_selected(index: int) -> void:
	var attribute = type.get_item_text(index).split(" ", true, 1)[1]
	attribute_modifier["type"] = attributes[attribute]["id"]
	_update()

func _on_operation_item_selected(index: int) -> void:
	attribute_modifier["operation"] = operations[operation.get_item_text(index)]["id"]
	_update()

func _on_amount_value_changed(value: float) -> void:
	amount.value = clampf(value, -2147483648, 2147483647)
	attribute_modifier["amount"] = value
	_update()
