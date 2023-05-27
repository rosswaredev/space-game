extends AspectRatioContainer
class_name CardControl


var card: CardDefinition


func _ready():
	set_controls()


func set_card_details(card_definition: CardDefinition):
	card = card_definition
	set_controls()
	show()


func set_controls():
	if $NameLabel and card:
		$NameLabel.text = card.name
