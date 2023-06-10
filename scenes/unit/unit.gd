extends Area2D
class_name Unit


@onready var ShotTimer: Timer = $ShotTimer
@onready var Projectile = preload("res://scenes/projectile/projectile.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: SegmentedProgressBar = $HealthBar
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var _card: CardDefinition
var _is_enemy: bool


func _ready():
	area_entered.connect(_on_area_entered)
	ShotTimer.timeout.connect(_on_ShotTimer_timeout)
	ShotTimer.start()


func _on_area_entered(_area):
	print('entered')


func _on_ShotTimer_timeout():
	var projectile = Projectile.instantiate()
	projectile.direction.y = 1 if _is_enemy else -1
	add_child(projectile)
	projectile.init(_is_enemy)

	animation_player.play("recoil")


func init(card: CardDefinition, pos: Vector2, is_enemy: bool):
	_card = card
	_is_enemy = is_enemy
	position = pos
	sprite.texture = load("res://assets/ships/" + card.texture)
	sprite.texture
	sprite.flip_v = is_enemy

	print(sprite.flip_v)

	health_component.max_health = card.health
	health_component.health = card.health
	health_bar.max_value = card.health
	health_bar.value = card.health

	var collision_layer = Constants.ENEMY_UNIT_LAYER if is_enemy else Constants.PLAYER_UNIT_LAYER
	var mask_layer = Constants.ENEMY_PROJECTILE_LAYER if is_enemy else Constants.PLAYER_PROJECTILE_LAYER
	set_collision_layer_value(collision_layer, true)
	set_collision_mask_value(mask_layer, true)
