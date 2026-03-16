extends Node3D
@onready var camera_3d: Camera3D = $Body/CameraBase/Camera3D
@export var models:Array[PackedScene]
@onready var player_hud: Control = $playerHUD
@onready var projectile_spawner: MultiplayerSpawner = $projectileSpawner
@onready var lbl_player_name: Label3D = $Body/lblPlayerName

@onready var body: VehicleBody3D = $Body
@onready var audio_listener_3d: AudioListener3D = $Body/AudioListener3D

@export var modelSelected:int = 0

func _ready() -> void:
	body.global_transform = get_parent().get_parent().getSpawnPos()
	Global.connect("startRace", startRace)
	#lbl_player_name.text = name
	selectModel(modelSelected)
	set_multiplayer_authority(name.to_int())
	body.set_physics_process(false)
	if is_multiplayer_authority():
		camera_3d.make_current()
		audio_listener_3d.make_current()
		lbl_player_name.visible = false
		lbl_player_name.text = Global.username
	else:
		#player_hud.visible = false
		player_hud.queue_free()

func selectModel(modelId:int = 0):
	var modelToSelect = name.to_int() % models.size() if modelId == 0 else modelId
	var model = models[modelToSelect].instantiate()
	body.add_child(model)

func respawn(respawnTo):
	body.respawn(respawnTo)

func despawn():
	queue_free()

func spawnProjectile(s:Global.Spells = Global.Spells.MISSILE, gTransform:Transform3D = Transform3D()):
	var data = {
		spell = s,
		globalTransform = gTransform
	}
	projectile_spawner.spawn(data)

func startRace():
	body.set_physics_process(true)
