extends Node
class_name StoreManager


signal store_refreshed(card_offering: Array[CardDefinition])

var slot_count = 3
var card_offering: Array[CardDefinition]


func _ready():
	GameEvents.card_dropped_on_deck_slot.connect(on_card_dropped_on_deck_slot)


func refresh_store():
	for _i in range(slot_count):
		var random_card = Global.card_pool.pick_random()
		card_offering.append(random_card)
		print(random_card)

	store_refreshed.emit(card_offering)


func on_card_dropped_on_deck_slot(id: String, slot_number: int):
	print(id, slot_number)
