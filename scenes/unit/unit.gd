extends Node2D
class_name Unit


@onready var ShotTimer: Timer = $ShotTimer
@onready var Projectile = preload("res://scenes/projectile/projectile.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var _card: CardDefinition


func _ready():
	ShotTimer.timeout.connect(_on_ShotTimer_timeout)
	ShotTimer.start()


func _on_ShotTimer_timeout():
	var projectile = Projectile.instantiate()
	add_child(projectile)

	animation_player.play("recoil")


func init(card: CardDefinition, pos: Vector2):
	_card = card
	position = pos
	sprite.texture = load("res://assets/ships/" + card.texture)
