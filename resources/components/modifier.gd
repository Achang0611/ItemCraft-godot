class_name Modifier
extends Resource

@export
var type: ModifierType
@export
var slot: Slot
@export
var id: NamespacedId
@export
var amount: float
@export
var operation: Operation

func _to_string() -> String:
	return "{type:%s,slot:%s,id:%s,amount:%s,operation:%s}" % [type, slot, id, amount, operation]
