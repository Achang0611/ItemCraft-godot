extends VBoxContainer

signal update(blocks: Array[Item])
signal toggled_tooltip(toggle_on)

const Block = preload("res://scenes/block.tscn")

@onready var hide_tooltip_button: Button = $Label/HideTooltipButton
@onready var accepted_blocks: VBoxContainer = $ScrollContainer/AcceptedBlocks

var hide_tooltip = false :
	set(value):
		hide_tooltip = value
		if value:
			hide_tooltip_button.text = "Show tooltip"
		else:
			hide_tooltip_button.text = "Hide tooltip"
		toggled_tooltip.emit(value)

var blocks = []

func _update():
	blocks = []
	for block in accepted_blocks.get_children():
		blocks.append(block.item)
	
	update.emit(blocks)

func _on_hide_place_button_pressed() -> void:
	hide_tooltip = not hide_tooltip

func add_block(item: Item) -> void:
	var block = Block.instantiate()
	block.item_changed.connect(_update)
	block.tree_exited.connect(_update)
	accepted_blocks.add_child(block)
	block.item = item

func _on_add_block_pressed() -> void:
	add_block(Items.get_item("cobblestone"))
	_update()
