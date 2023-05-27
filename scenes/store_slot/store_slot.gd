extends Control
class_name StoreSlot


@onready var drag_card = $DragCard as DragCard


func set_card_details(card_definition: CardDefinition):
	drag_card.set_card_details(card_definition)
	drag_card.show()
