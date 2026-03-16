extends MultiplayerSpawner
#@onready var spawn_point: Node3D = $"../spawnPoint"
@onready var players_connected: Control = $"../playersConnected"
@export var networkPlayer: PackedScene
const MISSILE = preload("uid://dao4ok5uv6imf")
const PARRY = preload("uid://cd7e28n831lit")

func _ready() -> void:
	multiplayer.peer_connected.connect(spawnPlayer)
	spawn_function = Callable(self, "spawnPlayerCar")

#func peerConnected(id):
	#players_connected.addPlayer(str(id))

func spawnPlayer(id: int):
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	spawn({id = id, modelSelected = randi() % player.models.size()})
	player.queue_free()
	return
	
	player.name = str(id)
	#player.modelSelected = randi() % player.models.size()
	
	if player.global_position is Vector3:
		#player.global_position = Vector3(0, 1.46, 0)
		#player.global_position = spawn_point.getNextSpawn()
		#player.global_position = get_parent().getSpawnPos()
		pass
	else:
		player.global_position = Vector2(455, 79)
	
	get_node(spawn_path).call_deferred("add_child", player)
	
	Global.notify.emit("Player spawned with name: " + player.name)

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
	
	
