extends Node3D
class_name WallClass
@onready var release: Timer = $release
@onready var mesh: MeshInstance3D = $mesh
@onready var despawn: Timer = $despawn
@onready var cs: CollisionShape3D = $sb/cs

@export var timerRelease:float = 1.5
@export var tweenTime:float = 0.1
@export var timerDespawn:float = 15.0

func _ready() -> void:
	release.start(timerRelease)

func _on_release_timeout() -> void:
	increase()

func increase():
	var t1 = create_tween()
	var t2 = create_tween()
	t2.tween_property(mesh, "mesh:size:y", 7, tweenTime)
	t1.tween_property(cs, "shape:size:y", 7, tweenTime)
	mesh.mesh.material.set_albedo(Color(0.322, 0.322, 0.322, 1.0))
	await t1.finished
	despawn.start(timerDespawn)

func _on_despawn_timeout() -> void:
	queue_free()
