extends Node3D

@export var currentSpawn:int = 0

func getNextSpawn():
	var count = 0
	for c in get_children():
		if c is not Node3D: continue
		if currentSpawn == count:
			currentSpawn += 1
			if currentSpawn > get_child_count():
				currentSpawn = 0
			return c.global_position
		count += 1
	return global_position
