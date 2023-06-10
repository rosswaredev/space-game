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


func init(is_from_enemy: bool):
	var collision_layer = Constants.ENEMY_PROJECTILE_LAYER if is_from_enemy else Constants.PLAYER_PROJECTILE_LAYER
	var mask_layer = Constants.PLAYER_UNIT_LAYER if is_from_enemy else Constants.ENEMY_UNIT_LAYER
	set_collision_layer_value(collision_layer, true)
	set_collision_mask_value(mask_layer, true)
