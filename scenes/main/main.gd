extends Node


@onready var store_screen = %StoreScreen as StoreScreen

var gold = 12


func _ready() -> void:
	store_screen.spend_gold.connect(on_spend_gold)

	store_screen.display_gold(12)


func on_spend_gold(gold_amount: int) -> void:
	gold = max(gold - gold_amount, 0)
	store_screen.display_gold(gold)
