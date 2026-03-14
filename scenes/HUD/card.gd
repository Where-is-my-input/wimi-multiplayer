extends Control

@export var effect:Node

func activate(body:VehicleBody3D):
	if effect == null || body == null: queue_free()
	effect.activate(body)
