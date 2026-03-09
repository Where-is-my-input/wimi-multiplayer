extends Area3D

var nextCheckpoint:Area3D

func setAsLapStart():
	for c in get_children():
		if c is MeshInstance3D:
			c.mesh.material.set_albedo(Color())
