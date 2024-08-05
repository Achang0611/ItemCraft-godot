extends Control

signal hover(item_id)
signal select(item_id)

@onready var items: HFlowContainer = $VBoxContainer/ScrollContainer/Items
@onready var search_bar: LineEdit = $VBoxContainer/SearchBar

func _ready() -> void:
	for item_id in Items.get_items():
		var item_texture = TextureRect.new()
		item_texture.texture = Items.get_item_texture(item_id)
		item_texture.name = item_id
		item_texture.tooltip_text = Items.get_item_name(item_id)
		item_texture.custom_minimum_size = Vector2(128, 128)
		item_texture.gui_input.connect(func(event):
			if event is InputEventMouseButton and event.is_action_pressed("left_click"):
				select.emit(item_id)
		)
		item_texture.mouse_entered.connect(func():
			hover.emit(item_id)
		)
		
		items.add_child(item_texture)

func show_item(filter: Callable):
	for item_texture in items.get_children():
		item_texture.visible = filter.callv([item_texture.name])

func search(name: String):
	name = name.to_lower().replace(" ", "_")
	show_item(func(id): 
		return id.begins_with(name) or id.contains(name)
	)
