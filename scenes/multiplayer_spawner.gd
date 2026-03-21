extends MultiplayerSpawner
#@onready var spawn_point: Node3D = $"../spawnPoint"
@onready var players_connected: Control = $"../playersConnected"
@export var networkPlayer: PackedScene
const MISSILE = preload("uid://dao4ok5uv6imf")
const PARRY = preload("uid://cd7e28n831lit")

func _ready() -> void:
	multiplayer.peer_connected.connect(spawnPlayer)
	spawn_function = Callable(self, "spawnPlayerCar")

func spawnPlayer(id: int):
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	spawn({id = id, modelSelected = randi() % player.models.size()})
	player.queue_free()
	
	Global.notify.emit("Peer id " + str(id) + " spawned")

func spawnAllPeers():
	if !multiplayer.is_server(): return
	spawnPlayer(1)
	
	for p in multiplayer.get_peers():
		spawnPlayer(p)

func spawnPlayerCar(data:Variant):
	var player: Node = networkPlayer.instantiate()
	player.name = str(data["id"])
	player.modelSelected = data["modelSelected"]
	return player
	
	
