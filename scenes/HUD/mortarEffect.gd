extends EffectClass
func activate(body:VehicleBody3D):
	body.get_parent().spawnProjectile(Global.Spells.MORTAR)
	super(body)
