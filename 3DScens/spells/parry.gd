extends Area3D

func _ready() -> void:
	var parent = get_parent() as VehicleBody3D
	parent.set_collision_mask_value(9, false)

func _on_body_entered(body: Node3D) -> void:
	if body != get_parent():
		if body is VehicleBody3D:
			body.linear_velocity *= 0.5
		elif body is CharacterBody3D:
			body.queue_free()


func _on_timer_timeout() -> void:
	visible = false
	monitoring = false
	await get_tree().create_timer(2).timeout
	get_parent().set_collision_mask_value(9, true)
	queue_free()
