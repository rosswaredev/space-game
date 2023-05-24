extends CanvasLayer


@onready var draggable_card = preload("res://scenes/draggable_card/draggable_card.tscn")

@export var store_manager: StoreManager

var card_offering: Array[CardDefinition] = []

var card_slot_index_in_hand = -1


func _ready():
	store_manager.store_refreshed.connect(on_store_refreshed)
	GameEvents.card_grabbed_from_slot.connect(on_card_grabbed_from_slot)
	GameEvents.card_released.connect(on_card_released)
	GameEvents.card_dropped_on_deck_slot.connect(on_card_dropped_on_deck_slot)


func on_store_refreshed(cards: Array[CardDefinition]):
	card_offering = cards
	print('on_store_refreshed', card_offering)

	for card in card_offering:
		var card_control = draggable_card.instantiate()
		print(card.id)
		card_control.set_card_details(card)
		$%Container.add_child(card_control)


func on_card_grabbed_from_slot(slot_number: int):
	print('card grabbled', slot_number)
	card_slot_index_in_hand = slot_number


func on_card_released():
	card_slot_index_in_hand = -1
	

func on_card_dropped_on_deck_slot(id: String, slot_number: int):
	print('on card dropped store', card_slot_index_in_hand)
	if (card_slot_index_in_hand != -1):
		card_offering.remove_at(card_slot_index_in_hand)
		var child_to_remove = $%Container.get_child(card_slot_index_in_hand)
		print('remove', child_to_remove)
		$%Container.remove_child(child_to_remove)

