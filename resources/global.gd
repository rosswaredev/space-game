extends Node

var card_pool: Array[CardDefinition] = [
#	CardDefinition.new("energy-shield", "Energy Shield", "I protec"),
#	CardDefinition.new("flame-thrower", "Flame Thrower", "Hot"),
#	CardDefinition.new("laser-beam", "Laser Beam", "Pew pew"),
#	CardDefinition.new("plasma-gun", "Plasma Gun", "Plasma Gun"),
#	CardDefinition.new("rapid-fire", "Rapid Fire", "Increase fire rate"),
#	CardDefinition.new("repair-module", "Repair Module", "Repairs the ship"),
]

@onready var game_node = get_tree().get_first_node_in_group("game")

var current_scene = null


func _ready() -> void:
	_load_cards()
	
	current_scene = game_node.get_child(game_node.get_child_count() - 1)


func change_scene(scene_path: String):
	call_deferred("_deferred_change_scene", scene_path)


func _deferred_change_scene(scene_path: String):
	current_scene.free()
	var next_scene = ResourceLoader.load(scene_path)

	current_scene = next_scene.instantiate()
	game_node.add_child(current_scene)

func _load_cards() -> void:
	var json_text = FileAccess.get_file_as_string("res://resources/cards/card_pool.json")
	var json = JSON.parse_string(json_text)
	
	if json == null:
		print('Failed loading cards')
		return
	
	for card_data in json:
		card_pool.append(
			CardDefinition.new(card_data.id, card_data.name, "desc", card_data.texture, card_data.attack, card_data.health)
		)
