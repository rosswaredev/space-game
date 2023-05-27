extends Control
class_name StoreSlot


@onready var drag_card = $DragCard as DragCard


func set_slot_index(slot_index: int) -> void:
	drag_card.slot_index = slot_index


func set_card_details(card_definition: CardDefinition):
	if card_definition == null:
		drag_card.hide()
	else:
		drag_card.set_card_details(card_definition)
		drag_card.show()
