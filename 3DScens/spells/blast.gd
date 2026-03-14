extends Area3D
class_name BlastClass

@export var blastStrength:float = 25.0
@export var scaleIncreaseTo:float = 18.0

func _ready():
	connect("body_entered", blastEffect)
	var t = create_tween()
	t.tween_property(self, "scale", Vector3(scaleIncreaseTo, scaleIncreaseTo, scaleIncreaseTo), 0.1)
	#await get_tree().create_timer(0.5).timeout
	await t.finished
	queue_free()

func blastEffect(body:Node3D):
	if body is not VehicleBody3D: return
	var vector_to_target = (body.global_position - global_position)
	body.linear_velocity -= (blastStrength / vector_to_target.length()) * vector_to_target.normalized() * -1 * Vector3(1, -1.0001, 1)
