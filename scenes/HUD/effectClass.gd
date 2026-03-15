extends Node
class_name EffectClass

func activate(_body:VehicleBody3D):
	get_parent().queue_free()
