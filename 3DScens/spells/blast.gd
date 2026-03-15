extends Area3D
class_name BlastClass

@export var blastStrength:float = 25.0
@export var scaleIncreaseTo:float = 18.0
@export var angularStrength:float = 25.0

func _ready():
	connect("body_entered", blastEffect)
	var t = create_tween()
	t.tween_property(self, "scale", Vector3(scaleIncreaseTo, scaleIncreaseTo, scaleIncreaseTo), 0.1)
	await t.finished
	queue_free()

func blastEffect(body:Node3D):
	if body is not VehicleBody3D: return
	var vector_to_target = (body.global_position - global_position)
	var vectorLength = angularStrength if vector_to_target.length() == 0 else vector_to_target.length()
	body.linear_velocity -= (blastStrength / vectorLength) * vector_to_target.normalized() * -1 * Vector3(1, -1.0001, 1)
	body.angular_velocity -= (angularStrength / vectorLength) * vector_to_target.normalized() * -1 * Vector3(1, -1.0001, 1).normalized()
	body.setRespawnCooldown(10)
