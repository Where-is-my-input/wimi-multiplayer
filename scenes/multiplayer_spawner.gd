extends MultiplayerSpawner
#@onready var spawn_point: Node3D = $"../spawnPoint"
@onready var players_connected: Control = $"../playersConnected"
@export var networkPlayer: PackedScene

func _ready() -> void:
	multiplayer.peer_connected.connect(spawnPlayer)
	multiplayer.peer_connected.connect(peerConnected)

func peerConnected(id):
	players_connected.addPlayer(str(id))

func spawnPlayer(id: int):
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	player.name = str(id)
	
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
