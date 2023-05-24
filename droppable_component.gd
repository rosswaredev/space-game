extends Control

var has_card = false

func _can_drop_data(at_position: Vector2, data) -> bool:
	return true

func _drop_data(at_position: Vector2, data) -> void:
	has_card = true
