extends Control

@export var player_scene:PackedScene
@onready var spawn_point: Node3D = $"../spawnPoint"
#@onready var spawn_point: Node3D = $spawnPoint
@onready var multiplayer_spawner: MultiplayerSpawner = $"../MultiplayerSpawner"
@onready var btn_client: Button = $VBoxContainer/btnClient

func _ready() -> void:
	btn_client.grab_focus()
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.server_disconnected.connect(_on_disconnected)
	multiplayer_spawner.networkPlayer = player_scene
	multiplayer_spawner.add_spawnable_scene(player_scene.resource_path)

func _on_btn_client_pressed() -> void:
	HighLevelNetworkHandler.startClient()


func _on_btn_server_pressed() -> void:
	print("Starting server...")
	HighLevelNetworkHandler.startServer()

	if multiplayer.is_server():
		print("Server started, spawning player...")
		#var player_scene = load("res://scenes/player.tscn")
		var player = player_scene.instantiate()
		player.name = "1"  # Server has peer ID 1
		if player.global_position is Vector3:
			player.global_position = Vector3(0, 1.46, 0)
			player.global_position = spawn_point.getNextSpawn()
		else:
			player.global_position = Vector2(455, 79)
		get_tree().current_scene.add_child(player)
		print("Server player spawned with name: ", player.name)
		set_buttons_visibility(false)
	else:
		print("Failed to start server or not server")

func _on_connected_to_server() -> void:
	set_buttons_visibility(false)

func _on_disconnected() -> void:
	set_buttons_visibility(true)

func set_buttons_visibility(should_show: bool) -> void:
	$VBoxContainer/btnServer.visible = should_show
	$VBoxContainer/btnClient.visible = should_show
