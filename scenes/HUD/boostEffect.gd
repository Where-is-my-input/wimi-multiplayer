extends EffectClass

func activate(body:VehicleBody3D):
	body.linear_velocity *= 2.5
	#var storedEngineForce = body.engine_force_value
	#body.engine_force_value *= 2
	#await get_tree().create_timer(2).timeout
	#body.engine_force_value = storedEngineForce
	super(body)
