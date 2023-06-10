extends Node2D
class_name Game


@onready var store_screen = %StoreScreen as StoreScreen

var gold = 99
var deck: Array[CardDefinition] = [null, null, null, null, null, null]


func _ready() -> void:
	GameEvents.screen_changed.connect(_on_screen_changed)



	store_screen.spend_gold.connect(on_spend_gold)
	store_screen.deck_changed.connect(on_deck_changed)
	store_screen.display_gold(12)


func _on_screen_changed(screen: GameEvents.Screen, scene):
	match screen:
		GameEvents.Screen.BATTLE:
			_connect_battle_screen(scene)


func _connect_battle_screen(battle_screen: BattleScreen):
	battle_screen.spawn_units_from_deck(deck)


func on_spend_gold(gold_amount: int) -> void:
	gold = max(gold - gold_amount, 0)
	store_screen.display_gold(gold)


func on_deck_changed(deck_cards: Array[CardDefinition]) -> void:
	deck = deck_cards
	store_screen.display_deck_cards(deck)

