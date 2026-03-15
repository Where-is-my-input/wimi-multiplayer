extends Label3D

func _process(_delta: float) -> void:
	look_at(get_viewport().get_camera_3d().global_position)
	rotate_y(230)
