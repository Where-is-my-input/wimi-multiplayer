extends Area3D
class_name BlastClass

@export var blastStrength:float = 25.0
@export var scaleIncreaseTo:float = 18.0

func _ready():
	connect("body_entered", blastEffect)
	var t = create_tween()
	t.tween_property(self, "scale", Vector3(scaleIncreaseTo, scaleIncreaseTo, scaleIncreaseTo), 0.2)
	#await get_tree().create_timer(0.5).timeout
	await t.finished
	queue_free()

func blastEffect(body:Node3D):
	#Global.notify.emit(str(body) + " detected by blast " + str(self))
	if body is not VehicleBody3D: return
	Global.notify.emit(str(body) + " hit by blast " + str(self))
	var vector_to_target = (body.global_position - global_position)
	body.linear_velocity *= (blastStrength / vector_to_target.length()) * vector_to_target.normalized() * -1
