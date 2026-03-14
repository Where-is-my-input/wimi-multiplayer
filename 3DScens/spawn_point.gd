extends Node3D

@export var currentSpawn:int = 0
@onready var spawn_points: Node3D = $spawnPoints

func getNextSpawn():
	var count = 0
	for c in spawn_points.get_children():
		if c is not Node3D: continue
		if currentSpawn == count:
			currentSpawn += 1
			if currentSpawn > spawn_points.get_child_count() - 1:
				currentSpawn = 0
			return c.global_position
		count += 1
	if currentSpawn > spawn_points.get_child_count() - 1:
		currentSpawn = 0
	return spawn_points.get_child(0).global_position
