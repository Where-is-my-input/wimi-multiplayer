extends VehicleBody3D

@export var maxSteer = 0.3
@export var enginePower = 650000

var spawnPos:Vector3

func _ready() -> void:
	set_multiplayer_authority(name.to_int())
	spawnPos = global_position
	#if spawn_point != null:
		#global_position = spawn_point.global_position

func _physics_process(delta: float) -> void:
	#print(global_position)
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * maxSteer, delta * 2.5)
	engine_force = Input.get_axis("ui_down", "ui_up") * enginePower
	#print(steering, " - ", engine_force, " - ", global_position)
	#print(name)

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		global_position = spawnPos
