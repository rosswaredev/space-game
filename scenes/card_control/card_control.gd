extends Control
class_name CardControl

@onready var ShipTexture: TextureRect = $ShipTexture
@onready var AttackLabel: Label = %AttackLabel
@onready var HealthLabel: Label = %HealthLabel

var card: CardDefinition


func _ready():
#	set_controls()
	pass


func set_card_details(card_definition: CardDefinition):
	card = card_definition

	set_controls()


func set_controls():
	if $NameLabel and card:
		$NameLabel.text = card.name
		AttackLabel.text = str(card.attack)
		HealthLabel.text = str(card.health)
		ShipTexture.texture = load('res://assets/ships/' + card.texture)
	else:
		self.modulate.a = 0

