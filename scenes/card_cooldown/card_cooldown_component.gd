extends Node2D

@onready var progress = $CooldownProgress;
@onready var timer = $CooldownTimer;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress.value = timer.time_left / timer.wait_time * progress.max_value

