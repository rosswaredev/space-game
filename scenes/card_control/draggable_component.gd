extends Control
class_name DraggableCard

var card: CardDefinition
var CardControl = preload("res://scenes/card_control/card_control.tscn")

@onready var camera = get_parent().get_parent()

@export var slot_number: int


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			$CardControl.show()
			release_card.call_deferred()



func set_card_details(card_definition: CardDefinition):
	card = card_definition
	$CardControl.set_card_details(card_definition)


func make_drag_preview() -> Control:
	var preview = Control.new()
	preview.add_child(self.duplicate())
	return preview
	

func release_card():
	GameEvents.card_released.emit()


func _get_drag_data(_at_position: Vector2):
	var preview = make_drag_preview()
	set_drag_preview(preview)
	$CardControl.hide()
	GameEvents.card_grabbed_from_slot.emit(slot_number)
	return card.id



