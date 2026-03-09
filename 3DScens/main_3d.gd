extends Node3D
#@onready var spawn_point: Node3D = %spawnPoint
@onready var spawn_point: Node3D = $spawnPoint
@onready var players: Node = $players

func _ready() -> void:
	Global.connect("startRace", startRace)

func getSpawnPos():
	return spawn_point.getNextSpawn()

@rpc("call_local")
func startRace():
	#if !multiplayer.is_server(): return
	for c in players.get_children():
		var posToSpawn = getSpawnPos()
		print(posToSpawn)
		c.respawn(posToSpawn)
	Global.notify.emit("Race started")

func _input(event: InputEvent) -> void:
	if multiplayer.is_server() && event.is_action("play"):
		if multiplayer.is_server():
			startRace.rpc()
