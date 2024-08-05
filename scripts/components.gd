extends Node

const _text = {
	"text": "",
	"bold": false,
	"italic": true,
	"underlined": false,
	"strikethrough": false,
	"obfuscated": false,
}

const _attribute_modifier = {
	"type": "generic.armor",
	"slot": "",
	"amount": 0,
	"operation": "add_value",
	"id": ""
}

func text():
	return _text.duplicate()

func attribute_modifier():
	return _attribute_modifier.duplicate()
