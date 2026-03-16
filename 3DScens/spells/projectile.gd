extends CharacterBody3D
class_name ProjectileClass

@export var direction:Vector3 = Vector3(1, 0, 1)
@export var speed:float = 2500.0

func _physics_process(delta: float) -> void:
	velocity = basis.z * speed * delta * direction
	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

func _on_failsafe_timeout() -> void:
	queue_free()
