extends Control
class_name StoreScreen


signal spend_gold(gold_amount: int)
signal deck_changed(cards: Array[CardDefinition])

@onready var StoreSlot = preload("res://scenes/store_slot/store_slot.tscn")
@onready var card_container = $%CardContainer
@onready var refresh_button = $%RefreshButton
@onready var gold_label = $%GoldLabel
@onready var deck = $%Deck

var REFRESH_COST = 1
var CARD_COST = 3
var slot_count = 3
var card_offering: Array[CardDefinition]
var gold = 0

func _ready():
	refresh_button.pressed.connect(on_refresh_button_pressed)

	var deck_slots = deck.get_children() as Array[DeckSlot]
	for index in deck_slots.size():
		var deck_slot = deck_slots[index]
		deck_slot.card_dropped.connect(on_card_dropped_on_deck_slot.bind(index))

	refresh_store()


func _can_drop_data(_at_position: Vector2, _data) -> bool:
	return true


func _drop_data(_at_position: Vector2, _data) -> void:
	display_cards()


func refresh_card_offering():
	card_offering = []
	for _i in range(slot_count):
		var random_card = Global.card_pool.pick_random()
		card_offering.append(random_card)


func display_cards():
	for child_node in card_container.get_children():
		card_container.remove_child(child_node)

	for card in card_offering:
		var store_slot = StoreSlot.instantiate()
		card_container.add_child(store_slot)
		store_slot.set_card_details(card)


func display_gold(gold_amount: int):
	gold = gold_amount
	gold_label.text = "%dg" % gold


func refresh_store():
	refresh_card_offering()
	display_cards()


func on_refresh_button_pressed():
	if gold == 0: return

	refresh_store()
	spend_gold.emit(REFRESH_COST)


func on_card_dropped_on_deck_slot(card: CardDefinition, deck_slot_index: int):
	if gold < CARD_COST: return

	spend_gold.emit(CARD_COST)
	deck_changed.emit(card, deck_slot_index)
