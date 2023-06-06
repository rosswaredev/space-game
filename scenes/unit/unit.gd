extends Node2D
class_name Unit


@onready var ShotTimer: Timer = $ShotTimer
@onready var Projectile = preload("res://scenes/projectile/projectile.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	print('hey')
	ShotTimer.timeout.connect(_on_ShotTimer_timeout)
	
	ShotTimer.start()


func _on_ShotTimer_timeout():
	var projectile = Projectile.instantiate()
	add_child(projectile)
	
	animation_player.play("recoil")
