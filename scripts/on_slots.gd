extends Control

signal update(slots)

const slots = preload("res://slots_1.21.json").data

@onready var debounce: Timer = $Debounce

var toggled_count = {}
var toggled_slots = []

func solve_dependecy() -> void:
	for slot in slots:
		var equivalent = slots[slot]["equivalent"]
		if not equivalent:
			continue
		
		var root_node = find_child(slot)
		toggled_count[slot] = 0
		var equ_node = equivalent.map(func(eq): return find_child(eq))
		
		root_node.toggled.connect(func(toggled_on):
			if not toggled_on and toggled_count[slot] == equivalent.size():
				equ_node.map(func(node): node.button_pressed = false)
			
			equ_node.map(func(node):
				if toggled_on:
					node.button_pressed = toggled_on
		))
		equ_node.map(func(node): 
			node.toggled.connect(func(toggled_on):
				if toggled_on:
					toggled_count[slot] += 1
				else:
					toggled_count[slot] -= 1
					root_node.button_pressed = false
				if toggled_count[slot] == equivalent.size():
					root_node.button_pressed = true
		))

func load_button() -> void:
	for slot in get_tree().get_nodes_in_group("slot"):
		slot.toggled.connect(func(t): on_slot_toggled(slot.name, t))

func _ready() -> void:
	load_button()
	solve_dependecy()
	$Any.button_pressed = true

func on_slot_toggled(slot: String, toggled_on: bool):
	if toggled_on:
		toggled_slots.append(slot)
	else:
		toggled_slots.erase(slot)
	
	debounce.start()

func simplify_update() -> void:
	if toggled_slots.has("Any"):
		update.emit([])
		return
		
	var simplify_slots = toggled_slots.duplicate()
	var to_remove = []
	for slot in simplify_slots:
		var equivalent = slots[slot]["equivalent"]
		if not equivalent:
			continue
		
		for equ in equivalent:
			if to_remove.has(equ):
				continue
			to_remove.append(equ)
	for remove in  to_remove:
		simplify_slots.erase(remove)
	
	update.emit(simplify_slots.map(func(slot): return slots[slot]["id"]))

func _on_debounce_timeout() -> void:
	simplify_update()
