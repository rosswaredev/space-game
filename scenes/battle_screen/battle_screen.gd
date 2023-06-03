extends CanvasLayer
class_name BattleScreen


signal battle_screen_ready

@onready var deck_ui = %Deck

var deck_cards: Array[CardDefinition] = []


func _ready() -> void:
	GameEvents.screen_changed.emit(GameEvents.Screen.BATTLE, self)


func display_deck(cards: Array[CardDefinition]) -> void:
	deck_cards = cards

	var deck_ui_cards = deck_ui.get_children()
	for deck_card_index in deck_ui_cards.size():
		var deck_card: CardControl = deck_ui.get_child(deck_card_index)
		var card = cards[deck_card_index]

		deck_card.set_card_details(card)


