extends Control
class_name DragCard


@export var source: String
@export var slot_index = -1

@onready var card_control = $CardControl as CardControl

var card: CardDefinition
var isDragging = false


func _input(event: InputEvent) -> void:
	if !isDragging: return

	if not event is InputEventMouseButton: return

	if event.is_pressed(): return

	isDragging = false
	show()


func _get_drag_data(_at_position: Vector2):
	var preview = make_drag_preview()
	set_drag_preview(preview)

	var data = { "source": source, "card": card }
	if not slot_index == -1:
		data.source_slot_index = slot_index

	isDragging = true
	hide()

	return data


func set_card_details(card_definition: CardDefinition):
	card = card_definition
	card_control.set_card_details(card_definition)


func make_drag_preview() -> Control:
	var preview = Control.new()
	preview.add_child(self.duplicate())
	return preview




