extends Node2D


@onready var store_manager: StoreManager = $StoreManager


func _ready() -> void:
	store_manager.refresh_store()
