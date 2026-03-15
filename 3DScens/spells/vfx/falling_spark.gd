extends Area3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export var color:Color = Color(233, 0, 0)

var linearVelocity:Vector3

func _ready() -> void:
	mesh_instance_3d.mesh.material.albedo_color = color
	linearVelocity *= -1

func _physics_process(delta: float) -> void:
	#global_position.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	global_position += Vector3(linearVelocity.x, ProjectSettings.get_setting("physics/2d/default_gravity"), linearVelocity.z) * delta


func _on_body_entered(_body: Node3D) -> void:
	queue_free()
