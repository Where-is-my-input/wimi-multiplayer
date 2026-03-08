extends Node3D
#@onready var spawn_point: Node3D = %spawnPoint
#@onready var spawn_point: Node3D = $spawnPoint
@onready var camera_3d: Camera3D = $Body/CameraBase/Camera3D

func _ready() -> void:
	global_position = get_parent().getSpawnPos()
	#global_position = spawn_point.getNextSpawn()
	print("Multiplayer authority will be set to: ", name.to_int())
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority(): camera_3d.make_current()
