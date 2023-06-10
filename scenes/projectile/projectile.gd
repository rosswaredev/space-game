extends Area2D


var speed = 1000
var direction = Vector2(0, -1)


func _ready():
	position.y += 30 * direction.y
	area_entered.connect(_on_Area2D_area_entered)


func _process(delta):
	position += delta * speed * direction


func _on_Area2D_area_entered(_area):
	queue_free()
