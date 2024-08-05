extends PanelContainer

signal item_changed

@onready var item_container: MarginContainer = $VBoxContainer/ItemContainer
@onready var item_texture: TextureRect = $VBoxContainer/ItemContainer/HBoxContainer/ItemTexture
@onready var item_name: Label = $VBoxContainer/ItemContainer/HBoxContainer/ItemName
@onready var item_selector: PanelContainer = $VBoxContainer/ItemSelector
@onready var mouse_check: Timer = $MouseCheck

@export
var item: Item :
	set(value):
		item = value
		show_item(value)
		item_changed.emit()

func _ready() -> void:
	item_selector.show_item(func(item):
		return item.is_block
	)

func show_item(item: Item) -> void:
	item_texture.texture = item.texture
	item_name.text = item.name

func _on_button_pressed() -> void:
	queue_free()

func open_selector() -> void:
	item_selector.visible = true
	mouse_check.start()

func close_selector() -> void:
	item_selector.visible = false
	mouse_check.stop()
	show_item(item)

func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		if item_selector.visible:
			close_selector()
		else:
			open_selector()

func _on_item_selector_select(select_item: Item) -> void:
	close_selector()
	item = select_item

func _on_mouse_check_timeout() -> void:
	var mouse_pos = get_global_mouse_position()
	var in_item = item_container.get_global_rect().has_point(mouse_pos)
	if in_item:
		show_item(item)
		return
	
	var in_block = get_global_rect().has_point(mouse_pos)
	if not in_block:
		close_selector()
