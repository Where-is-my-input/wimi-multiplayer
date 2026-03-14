extends EffectClass
const PARRY = preload("uid://cd7e28n831lit")

func activate(body:VehicleBody3D):
	var p = PARRY.instantiate()
	body.add_child(p)
	super(body)
