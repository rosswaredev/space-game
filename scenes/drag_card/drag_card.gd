extends Control
class_name DragCard



@export var source: String
@export var slot_index = -1

@onready var card_control = $CardControl as CardControl

var card: CardDefinition


func set_card_details(card_definition: CardDefinition):
	card = card_definition
	if (card_definition == null):
#		hide()
		pass
	else:
		card_control.set_card_details(card_definition)
		show()

func make_drag_preview() -> Control:
	var preview = Control.new()
	preview.add_child(self.duplicate())
	return preview



func _get_drag_data(_at_position: Vector2):
	var preview = make_drag_preview()
	set_drag_preview(preview)
	card_control.hide()

	var data = { "source": source, "card": card }
	if not slot_index == -1:
		data.source_slot_index = slot_index
	return data



