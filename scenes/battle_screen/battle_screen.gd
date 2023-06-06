extends CanvasLayer
class_name BattleScreen


signal battle_screen_ready

@onready var deck_ui = %Deck

var deck_cards: Array[CardDefinition] = []


func _ready() -> void:
	GameEvents.screen_changed.emit(GameEvents.Screen.BATTLE, self)


func display_deck(cards: Array[CardDefinition]) -> void:
	pass
