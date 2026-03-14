extends Node3D
@onready var camera_3d: Camera3D = $Body/CameraBase/Camera3D
const DELIVERY = preload("uid://bk1x4sh3lo7mt")
const AMBULANCE = preload("uid://dchk87sjuptte")
const DELIVERY_FLAT = preload("uid://cv3t3uq8lg3qu")
const FIRETRUCK = preload("uid://bh2woksc5jyy3")
const GARBAGE_TRUCK = preload("uid://cjjbrd2b1ihlf")
const HATCHBACK_SPORTS = preload("uid://dycaefnlknuuv")
const KART_OOBI = preload("uid://ckb7ukxlvhx20")
const KART_OODI = preload("uid://xi5aisljvf6k")
const KART_OOLI = preload("uid://dltckkwphjx3d")
const KART_OOPI = preload("uid://bxuufmcdvlkup")
const KART_OOZI = preload("uid://bjai5l2phpm8e")
const POLICE = preload("uid://tiv4c8qvoltp")
const RACE_FUTURE = preload("uid://cvcimg71nenk5")
const RACE = preload("uid://8wafqinedw14")
const SEDAN_SPORTS = preload("uid://y0gu2xamppi")
const SEDAN = preload("uid://dv8io88h20g2f")
const SUV_LUXURY = preload("uid://sxq4d7qeo7s")
const SUV = preload("uid://bimbs101ylfx2")
const TAXI = preload("uid://b6qg3t00jqe14")
const TRACTOR_POLICE = preload("uid://ck4vssnytmnxm")
const TRACTOR_SHOVEL = preload("uid://cvstn66c24k1r")
const TRACTOR = preload("uid://d07fyyhbg8n5w")
const TRUCK_FLAT = preload("uid://cju4xcsctrpvb")
const TRUCK = preload("uid://d0bd4c30nnxhv")
const VAN = preload("uid://bdh3x1rcfdepo")
@onready var player_hud: Control = $playerHUD

@onready var body: VehicleBody3D = $Body
@onready var audio_listener_3d: AudioListener3D = $Body/AudioListener3D

func _ready() -> void:
	global_position = get_parent().get_parent().getSpawnPos()
	Global.notify.emit("Multiplayer authority will be set to: " + name)
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority():
		camera_3d.make_current()
		audio_listener_3d.make_current()
	else:
		player_hud.visible = false
	selectModel()

func selectModel():
	var model
	match name.to_int() % 10:
		0:
			model = SEDAN_SPORTS.instantiate()
		1:
			model = RACE_FUTURE.instantiate()
		2:
			model = POLICE.instantiate()
		3:
			model = TAXI.instantiate()
		4:
			model = HATCHBACK_SPORTS.instantiate()
		5:
			model = SUV_LUXURY.instantiate()
		_:
			model = SEDAN.instantiate()
			
	body.add_child(model)

func respawn(respawnTo:Vector3 = Vector3(0,0,0)):
	body.respawn(respawnTo)

func despawn():
	queue_free()
