extends Node3D
@onready var track: Node = $track
const MISSILE = preload("uid://dao4ok5uv6imf")

#@export var raceTrack:Node3D
@onready var race_start_cooldown: Timer = $raceStartCooldown
@onready var bgm: AudioStreamPlayer2D = $BGM
@onready var track_spawner: MultiplayerSpawner = $trackSpawner
@onready var projectiles: Node = $projectiles

#@onready var spawn_point: Node3D = $spawnPoint
@onready var players: Node = $players
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

func _ready() -> void:
	#Global.connect("startRace", startRace)
	#Global.connect("spawnProjectile", spawnProjectile)
	if OS.is_debug_build():
		bgm.stop()

func getSpawnPos():
	var currentTrack = track.get_child(0)
	return currentTrack.getNextSpawn() if currentTrack != null else Transform3D()

#@rpc("call_local")
func prepareRace():
	if !race_start_cooldown.is_stopped(): return
	race_start_cooldown.start(3)
	#if !multiplayer.is_server(): return
	Global.notify.emit("Race will start soon...")
	track_spawner.loadTrack()
	await get_tree().create_timer(3).timeout
	for c in players.get_children():
		var posToSpawn = getSpawnPos()
		c.respawn(posToSpawn)
		c.despawn()
	multiplayer_spawner.spawnAllPeers()
	startRace.rpc()

@rpc("call_local")
func startRace():
	Global.notify.emit("3")
	await get_tree().create_timer(1).timeout
	Global.notify.emit("2")
	await get_tree().create_timer(1).timeout
	Global.notify.emit("1")
	await get_tree().create_timer(1).timeout
	Global.notify.emit("Race started!!!")
	for p in players.get_children():
		p.startRace()

func _input(event: InputEvent) -> void:
	if multiplayer.is_server() && event.is_action("play"):
		prepareRace()
