extends Control

signal update(enchantment: String, level: int)

const ENCHANTMENTS_1_21 = preload("res://enchantments_1.21.json").data

func set_level(value: int) -> void:
	$MarginContainer/VBoxContainer/SpinBox.value = value

func _on_spin_box_value_changed(value: float) -> void:
	var id = ENCHANTMENTS_1_21.filter(func(i): return i["name"] == name)[0]["id"]
	update.emit(id, int(value))
