extends Node3D
@onready var track: Node = $track
const MISSILE = preload("uid://dao4ok5uv6imf")
@onready var winner_cam_spawner: MultiplayerSpawner = $winner/winnerCamSpawner
#@export var raceTrack:Node3D
@onready var race_start_cooldown: Timer = $raceStartCooldown
@onready var bgm: AudioStreamPlayer2D = $BGM
@onready var track_spawner: MultiplayerSpawner = $trackSpawner
@onready var projectiles: Node = $projectiles
@onready var players_connected: Control = $playersConnected
#@onready var spawn_point: Node3D = $spawnPoint
@onready var players: Node = $players
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var world_environment: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	Global.connect("setWinner", spawnWinnerCam)

func getSpawnPos():
	var currentTrack = track.get_child(0)
	return currentTrack.getNextSpawn() if currentTrack != null else Transform3D()

#@rpc("call_local")
func prepareRace(trackId:int = -1):
	if !race_start_cooldown.is_stopped(): return
	race_start_cooldown.start(3)
	#if !multiplayer.is_server(): return
	Global.notify.emit("Race will start soon...")
	winner_cam_spawner.newRace()
	players_connected.resetCheckpointCount()
	#if world_environment != null: world_environment.queue_free()
	if trackId == -1:
		track_spawner.loadTrack()
	else:
		track_spawner.changeTrackTo(trackId)
	await get_tree().create_timer(1.5).timeout
	for c in players.get_children():
		var posToSpawn = getSpawnPos()
		c.respawn(posToSpawn)
		c.despawn()
	await get_tree().create_timer(1.5).timeout
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

#func _input(event: InputEvent) -> void:
	#if multiplayer.is_server() && event.is_action("play"):
		#prepareRace()

func spawnWinnerCam(peerId:int):
	winner_cam_spawner.spawn({peerId = peerId})
