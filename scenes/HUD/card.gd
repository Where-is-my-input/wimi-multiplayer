extends Control

@export var effect:Node
@export var spellType:Global.Spells = Global.Spells.MISSILE

func activate(body:VehicleBody3D):
	#var data = {
		#Spell = spellType,
		#body = body
	#}
	#Global.spawnProjectile.emit(data)
	#queue_free()
	#return
	if effect == null || body == null: queue_free()
	effect.activate(body)
