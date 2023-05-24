extends CanvasLayer

@onready var draggable_card = preload("res://scenes/draggable_card/draggable_card.tscn")

@export var store_manager: StoreManager

var card_offering: Array[CardDefinition] = []


func _ready():
	store_manager.store_refreshed.connect(on_store_refreshed)


func on_store_refreshed(cards: Array[CardDefinition]):
	card_offering = cards

	for card in card_offering:
		var card_control = draggable_card.instantiate()
		card_control.set_card_details(card)
		$%Container.add_child(card_control)
