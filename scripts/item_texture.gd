extends TextureRect

@export
var item: Item :
	set(value):
		item = value
		display(item)

func display(item: Item):
	texture = item.texture
	name = item.name
	tooltip_text = item.name
