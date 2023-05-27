extends Control
class_name DeckSlot


signal card_dropped(source: String, card: CardDefinition, source_slot_index: int)

@onready var drag_card: DragCard = $DragCard


func _ready():
	drag_card.slot_index = get_index()


func _can_drop_data(_at_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("source") and data.has("card") and data.has("source_slot_index")


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	card_dropped.emit(data.source, data.card, data.source_slot_index)


func set_card_details(card_definition: CardDefinition):
	drag_card.set_card_details(card_definition)
