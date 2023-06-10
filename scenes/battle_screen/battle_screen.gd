extends CanvasLayer
class_name BattleScreen


signal battle_screen_ready

@onready var unit_scene: PackedScene = preload("res://scenes/unit/unit.tscn")

var GRID_COLS = 3
var GRID_ROWS = 2
var GRID_GAP = 16
var CELL_WIDTH = 96
var CELL_HEIGHT = 96
var GRID_WIDTH = CELL_WIDTH * GRID_ROWS + (GRID_GAP * (GRID_ROWS - 1))
var GRID_HEIGHT = CELL_HEIGHT * GRID_COLS + (GRID_GAP * (GRID_COLS - 1))
var WIDTH = DisplayServer.window_get_size().x
var HEIGHT = DisplayServer.window_get_size().y
var PLAYER_GRID_POSITION = Vector2((WIDTH - GRID_WIDTH) / 2, HEIGHT / 2 + 200)
var ENEMY_GRID_POSITION = Vector2((WIDTH - GRID_WIDTH) / 2, HEIGHT / 2 - GRID_HEIGHT / 2 - 200)


func _ready() -> void:
	GameEvents.screen_changed.emit(GameEvents.Screen.BATTLE, self)

	spawn_enemy_units()


func spawn_units_from_deck(deck_cards: Array[CardDefinition]) -> void:
	spawn_units_at_position(PLAYER_GRID_POSITION, deck_cards)


func spawn_enemy_units() -> void:
	var enemy_cards: Array[CardDefinition] = []
	for _i in range(GRID_ROWS * GRID_COLS):
		var random_card = Global.card_pool.pick_random()
		enemy_cards.append(random_card)

	spawn_units_at_position(ENEMY_GRID_POSITION, enemy_cards)


func spawn_units_at_position(position: Vector2, deck_cards: Array[CardDefinition]):
	for row_index in GRID_ROWS:
		for col_index in GRID_COLS:
			var pos = Vector2(
				position.x + ((CELL_WIDTH + GRID_GAP) * col_index),
				position.y + ((CELL_HEIGHT + GRID_GAP) * row_index)
			)
			var deck_index = GRID_COLS * row_index + col_index
			var card = deck_cards[deck_index]

			if not card: continue

			spawn_unit(card, pos)


func spawn_unit(card, pos) -> void:
	var unit = unit_scene.instantiate() as Unit
	add_child(unit)
	unit.init(card, pos)
