extends Control
class_name DragCard


signal grabbed(card: CardDefinition)

var card: CardDefinition
var CardControl = preload("res://scenes/card_control/card_control.tscn")

@onready var camera = get_parent().get_parent()


func set_card_details(card_definition: CardDefinition):
	card = card_definition
	$CardControl.set_card_details(card_definition)


func make_drag_preview() -> Control:
	var preview = Control.new()
	preview.add_child(self.duplicate())
	return preview


func _get_drag_data(_at_position: Vector2):
	var preview = make_drag_preview()
	set_drag_preview(preview)
	$CardControl.hide()
	grabbed.emit()
	return card.id



