extends Control
class_name StoreScreen


signal spend_gold(gold_amount: int)
signal deck_changed(deck_cards: Array[CardDefinition])

@onready var StoreSlot = preload("res://scenes/store_slot/store_slot.tscn")
@onready var card_container = $%CardContainer
@onready var refresh_button = $%RefreshButton
@onready var gold_label = $%GoldLabel
@onready var deck = $%Deck

var REFRESH_COST = 1
var CARD_COST = 3
var slot_count = 3
var gold = 0
var card_offering: Array[CardDefinition] = []
var deck_cards: Array[CardDefinition] = [
	null, null, null,
	null, null, null
]

func _ready():
	refresh_button.pressed.connect(on_refresh_button_pressed)

	var deck_slots = deck.get_children() as Array[DeckSlot]
	for index in deck_slots.size():
		var deck_slot = deck_slots[index]
		deck_slot.card_dropped.connect(on_card_dropped_on_deck_slot.bind(index))

	refresh_store()


func _can_drop_data(_at_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("source")


func _drop_data(_at_position: Vector2, data) -> void:
	if data.source == "store":
		display_store_cards()
	elif data.source == "deck":
		display_deck_cards(deck_cards)


func refresh_card_offering() -> void:
	card_offering = []
	for _i in range(slot_count):
		var random_card = Global.card_pool.pick_random()
		card_offering.append(random_card)


func display_store_cards() -> void:
	for child_node in card_container.get_children():
		card_container.remove_child(child_node)

	for slot_index in card_offering.size():
		var card = card_offering[slot_index]
		var store_slot = StoreSlot.instantiate()
		card_container.add_child(store_slot)
		store_slot.set_slot_index(slot_index)
		store_slot.set_card_details(card)


func display_deck_cards(cards: Array[CardDefinition]) -> void:
	deck_cards = cards
	for deck_slot_index in deck_cards.size():
		var deck_slot = deck.get_child(deck_slot_index) as DeckSlot
		var card = deck_cards[deck_slot_index]
		deck_slot.set_card_details(card)


func display_gold(gold_amount: int):
	gold = gold_amount
	gold_label.text = "%dg" % gold


func refresh_store():
	refresh_card_offering()
	display_store_cards()


func on_refresh_button_pressed():
	if gold == 0: return

	refresh_store()
	spend_gold.emit(REFRESH_COST)


func on_card_dropped_on_deck_slot(source: String, card: CardDefinition, source_slot_index: int, deck_slot_index: int):
	if source == "store":
		purchase_card(card, source_slot_index, deck_slot_index)
	elif source == "deck":
		swap_cards(source_slot_index, deck_slot_index)


func swap_cards(source_slot_index: int, deck_slot_index: int) -> void:
	var existing_card = deck_cards[deck_slot_index]
	deck_cards[deck_slot_index] = deck_cards[source_slot_index]
	deck_cards[source_slot_index] = existing_card
	deck_changed.emit(deck_cards)


func purchase_card(card: CardDefinition, source_slot_index: int, deck_slot_index: int) -> void:
	var existing_card = deck_cards[deck_slot_index]

	if existing_card == null:
		if gold >= CARD_COST:
			card_offering[source_slot_index] = null
			spend_gold.emit(CARD_COST)
			place_card_in_deck(card, deck_slot_index)
	else:
		display_store_cards()

func place_card_in_deck(card: CardDefinition, deck_slot_index: int):
	deck_cards[deck_slot_index] = card
	deck_changed.emit(deck_cards)
