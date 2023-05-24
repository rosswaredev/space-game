extends Node
class_name StoreManager


signal store_refreshed(card_offering: Array[CardDefinition])

@export var card_manager: CardManager

var slot_count = 3
var card_offering: Array[CardDefinition]


func refresh_store():
	for _i in range(slot_count):
		card_offering.append(pick_random_card())

	store_refreshed.emit(card_offering)


func pick_random_card():
	var random_index = randi_range(0, card_manager.card_pool.size() - 1)
	return card_manager.card_pool[random_index]
