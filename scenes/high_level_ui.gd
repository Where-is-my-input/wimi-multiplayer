extends Control

@export var player_scene:PackedScene
@onready var multiplayer_spawner: MultiplayerSpawner = $"../MultiplayerSpawner"
@onready var btn_client: Button = $VBoxContainer/btnClient
@onready var ip: LineEdit = $VBoxContainer/ip
@onready var port: LineEdit = $VBoxContainer/port
@onready var players: Node = $"../players"
@onready var players_connected: Control = $"../playersConnected"
@onready var track_spawner: MultiplayerSpawner = $"../trackSpawner"

func _ready() -> void:
	btn_client.grab_focus()
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.server_disconnected.connect(_on_disconnected)
	multiplayer_spawner.networkPlayer = player_scene
	multiplayer_spawner.add_spawnable_scene(player_scene.resource_path)

func _on_btn_client_pressed() -> void:
	track_spawner.unloadTrack()
	HighLevelNetworkHandler.startClient(port.text, ip.text)

func _on_btn_server_pressed() -> void:
	track_spawner.unloadTrack()
	Global.notify.emit("Starting server...")
	HighLevelNetworkHandler.startServer(port.text)

	if multiplayer.is_server():
		Global.notify.emit("Server started, spawning player...")
		var player = player_scene.instantiate()
		player.name = "1"  # Server has peer ID 1
		players_connected.addPlayer(player.name)
		if player.global_position is Vector3:
			#player.global_position = Vector3(0, 1.46, 0)
			#player.global_position = get_parent().getSpawnPos()
			pass
		else:
			player.global_position = Vector2(455, 79)
		players.add_child(player)
		Global.notify.emit("Server player spawned with name: " + player.name)
		set_buttons_visibility(false)
	else:
		push_error("Failed to start server or not server")

func _on_connected_to_server() -> void:
	set_buttons_visibility(false)

func _on_disconnected() -> void:
	set_buttons_visibility(true)

func set_buttons_visibility(should_show: bool) -> void:
	visible = should_show
