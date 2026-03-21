extends Node3D
@onready var rc_3d: RayCast3D = $rc3d

func _ready() -> void:
	var ground = rc_3d.get_collider()
	if ground is GridMap:
		global_position.y = rc_3d.get_collision_point().y
	#else:
		#queue_free()
