extends BlastClass

func blastEffect(body:Node3D):
	super(body)
	if body == get_parent():
		#var randomValue = randi() % 10
		#if randomValue > 5:
			#body.angular_velocity.z += randomValue
			#body.angular_velocity.x += randomValue * -1
		#else:
		body.linear_velocity.y += 5
		body.angular_velocity.y += 6 if randi() % 2 == 0 else -6
