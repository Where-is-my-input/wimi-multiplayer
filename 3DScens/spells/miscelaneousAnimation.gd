extends Node3D

@export var ap:AnimationPlayer

func _ready() -> void:
	if ap == null: return
	await get_parent().ready
	ap.speed_scale = get_parent().speed
