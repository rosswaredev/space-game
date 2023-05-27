extends Control
class_name DeckSlot


signal card_dropped(card: CardDefinition)

@onready var card: DragCard = $DragCard


func _can_drop_data(_at_position: Vector2, _data) -> bool:
	return true


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	for card_definition in Global.card_pool:
		if card_definition.id == data:
			card.set_card_details(card_definition)
			card.show()
			card_dropped.emit(card_definition)
			break
