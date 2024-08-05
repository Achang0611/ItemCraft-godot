extends Control

signal hover(item: Item)
signal select(item: Item)

const ItemTexture = preload("res://scenes/item_texture.tscn")

@onready var items: HFlowContainer = $VBoxContainer/ScrollContainer/Items
@onready var search_bar: LineEdit = $VBoxContainer/SearchBar

func _ready() -> void:
	for item in Items.get_items():
		var item_texture = ItemTexture.instantiate()
		item_texture.item = item
		item_texture.gui_input.connect(func(event):
			if event is InputEventMouseButton and event.is_action_pressed("left_click"):
				select.emit(item)
		)
		item_texture.mouse_entered.connect(func():
			hover.emit(item)
		)
		
		items.add_child(item_texture)

func show_item(filter: Callable):
	for item_texture in items.get_children():
		item_texture.visible = filter.callv([item_texture.item])

func search(name: String):
	name = name.to_lower().replace(" ", "_")
	show_item(func(item): 
		return item.id.contains(name)
	)
