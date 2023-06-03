extends AspectRatioContainer
class_name CardControl


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
	else:
		self.modulate.a = 0

