extends Node
@onready var cone: Node3D = $"../SubViewportContainer/cone"
const MISSILE = preload("uid://dao4ok5uv6imf")

func _process(delta: float) -> void:
	cone.rotate(Vector3(0, 1, 0), 1.5 * delta)

func activate(body:VehicleBody3D):
	var m = MISSILE.instantiate() as ProjectileClass
	m.global_transform = body.gun.global_transform
	m.speed += body.linear_velocity.length()
	shootMissile(m)
	get_parent().queue_free()

#@rpc("call_local")
func shootMissile(m:ProjectileClass):
	#m.direction = Vector3(global_rotation.x, 0, global_rotation.z).normalized()
	#m.global_position = global_position
	#m.global_rotation = global_rotation
	#get_tree().root.add_child(m)
	Global.spawnProjectile.emit(m)
