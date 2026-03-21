extends Control
class_name CardClass

@export var used:bool = false
@export var effect:Node
@export var spellType:Global.Spells = Global.Spells.MISSILE

func activate(body:VehicleBody3D):
	if effect == null || body == null: queue_free()
	used = true
	effect.activate(body)
