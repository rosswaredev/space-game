extends Node
class_name HealthComponent


signal health_changed(amount: int)
signal died()

var health: int
var max_health: int


func take_damage(amount: int) -> void:
	health = max(health - amount, 0)

	health_changed.emit(health)

	if health == 0:
		died.emit()
