extends Node3D

@export var raceTrack:Node3D
@onready var race_start_cooldown: Timer = $raceStartCooldown
@onready var bgm: AudioStreamPlayer2D = $BGM

#@onready var spawn_point: Node3D = $spawnPoint
@onready var players: Node = $players
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

func _ready() -> void:
	Global.connect("startRace", startRace)
	if OS.is_debug_build():
		bgm.stop()

func getSpawnPos():
	return raceTrack.getNextSpawn()

@rpc("call_local")
func startRace():
	if !race_start_cooldown.is_stopped(): return
	race_start_cooldown.start(10)
	#if !multiplayer.is_server(): return
	Global.notify.emit("Race will start soon...")
	await get_tree().create_timer(3).timeout
	for c in players.get_children():
		var posToSpawn = getSpawnPos()
		print(posToSpawn)
		c.respawn(posToSpawn)
		c.despawn()
	multiplayer_spawner.spawnAllPeers()
	Global.notify.emit("Race started")

func _input(event: InputEvent) -> void:
	if multiplayer.is_server() && event.is_action("play"):
		if multiplayer.is_server():
			startRace.rpc()
