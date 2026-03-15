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
	Global.connect("startRace", startRace)
	#Global.connect("spawnProjectile", spawnProjectile)
	if OS.is_debug_build():
		bgm.stop()

func getSpawnPos():
	var currentTrack = track.get_child(0)
	return currentTrack.getNextSpawn() if currentTrack != null else Transform3D()

#@rpc("call_local")
func startRace():
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
	Global.notify.emit("Race started")

func _input(event: InputEvent) -> void:
	if multiplayer.is_server() && event.is_action("play"):
		startRace()

#func spawnProjectile(p:ProjectileClass):
	#projectiles.call_deferred("add_child", p)
#
#func spawnMissile(body:VehicleBody3D):
	#var m = MISSILE.instantiate() as ProjectileClass
	#m.global_transform = body.gun.global_transform
	#m.speed += body.linear_velocity.length()
	#projectiles.call_deferred("add_child", m)
	#Global.notify.emit(str(body) + " spawned a missile")
