extends Node
class_name EffectClass

@export var asset:Node3D

func _ready() -> void:
	if asset == null:
		set_process(false)

func _process(delta: float) -> void:
	asset.rotate(Vector3(0, 1, 0), 1.5 * delta)

func activate(body:VehicleBody3D):
	get_parent().queue_free()
