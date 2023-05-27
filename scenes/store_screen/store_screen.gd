extends Node
class_name StoreManager


signal store_refreshed(card_offering: Array[CardDefinition])

@onready var StoreSlot = preload("res://scenes/store_slot/store_slot.tscn")
@onready var card_container = $%CardContainer
@onready var refresh_button = $%RefreshButton
@onready var gold_label = $%GoldLabel

var REFRESH_COST = 1
var slot_count = 3
var card_offering: Array[CardDefinition]
var gold = 12


func _ready():
	refresh_button.pressed.connect(on_refresh_button_pressed)

	refresh_store()
	display_gold()


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


func display_gold():
	gold_label.text = "%dg" % gold


func refresh_store():
	refresh_card_offering()
	display_cards()


func on_refresh_button_pressed():
	if (gold >= REFRESH_COST):
		gold -= REFRESH_COST
		refresh_store()
		display_gold()
