extends Node3D
#@onready var spawn_point: Node3D = %spawnPoint
@onready var spawn_point: Node3D = $spawnPoint

func getSpawnPos():
	return spawn_point.getNextSpawn()
