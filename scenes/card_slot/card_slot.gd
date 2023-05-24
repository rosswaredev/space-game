extends Control


@export var slot_number: int

@onready var card: DraggableCard = $DraggableCard


func _ready():
	card.hide()


func _can_drop_data(at_position: Vector2, data) -> bool:
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	for card_definition in Global.card_pool:
		if card_definition.id == data:
			card.set_card_details(card_definition)
			card.show()
			GameEvents.card_dropped_on_deck_slot.emit(card_definition.id, slot_number)
			break
