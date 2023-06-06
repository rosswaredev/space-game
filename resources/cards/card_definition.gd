class_name CardDefinition

@export var id: String
@export var name: String
@export var description: String
@export var texture: String
@export var attack: int
@export var health: int


func _init(card_id = "", card_name = "", card_description = "", card_texture = null, card_attack = 1, card_health = 1):
	id = card_id
	name = card_name
	description = card_description
	texture = card_texture
	attack = card_attack
	health = card_health
