extends Node3D
#@onready var spawn_point: Node3D = %spawnPoint
@onready var spawn_point: Node3D = $spawnPoint
@onready var players: Node = $players

func _ready() -> void:
	Global.connect("startRace", startRace)

func getSpawnPos():
	return spawn_point.getNextSpawn()

func startRace():
	if !multiplayer.is_server(): return
	for c in players.get_children():
		var posToSpawn = getSpawnPos()
		print(posToSpawn)
		c.respawn(posToSpawn)
	Global.notify.emit("Race started")
