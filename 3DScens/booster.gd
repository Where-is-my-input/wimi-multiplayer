extends Area3D

@export var boostStrength:float = 15.0

func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D: 
		body.linear_velocity += boostStrength * body.linear_velocity.normalized()
		body.boost(1)
