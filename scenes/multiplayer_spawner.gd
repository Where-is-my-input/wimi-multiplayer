extends MultiplayerSpawner
#@onready var spawn_point: Node3D = %spawnPoint
@onready var spawn_point: Node3D = $"../spawnPoint"
@onready var players_connected: Control = $"../playersConnected"
@export var networkPlayer: PackedScene

func _ready() -> void:
	multiplayer.peer_connected.connect(spawnPlayer)

func spawnPlayer(id: int):
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	player.name = str(id)
	players_connected.addPlayer(player.name)
	
	if player.global_position is Vector3:
		#player.global_position = Vector3(0, 1.46, 0)
		player.global_position = spawn_point.getNextSpawn()
	else:
		player.global_position = Vector2(455, 79)
	
	get_node(spawn_path).call_deferred("add_child", player)
	
	Global.notify.emit("Player spawned with name: " + player.name)
