extends CharacterBody3D
class_name ProjectileClass

@export var direction:Vector3 = Vector3(1, 0, 1)
@export var speed:float = 25.0

func _ready() -> void:
	#direction = Vector3(global_rotation.x, 0, global_rotation.z).normalized()
	#global_position.y += 0
	#global_position.x -= 2
	pass

func _physics_process(delta: float) -> void:
	#velocity = speed * basis.get_euler() * Vector3(1, 0, 1)
	velocity = basis.z * 2500 * delta * direction
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.


func _on_failsafe_timeout() -> void:
	queue_free()
