extends Area3D
class_name ParryClass

func _ready() -> void:
	var parent = get_parent() as VehicleBody3D
	parent.set_collision_layer_value(9, false)

func _on_body_entered(body: Node3D) -> void:
	if body != get_parent():
		if body is VehicleBody3D:
			body.linear_velocity *= 0.5
		elif body is CharacterBody3D:
			body.queue_free()

func _on_timer_timeout() -> void:
	#return
	await get_tree().create_timer(5).timeout
	visible = false
	monitoring = false
	if get_parent() != null: get_parent().set_collision_layer_value(9, true)
	queue_free()
