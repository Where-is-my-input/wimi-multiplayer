extends RigidBody3D
@onready var area_3d: Area3D = $Area3D
@export var nailStrength:float = 25.0
@export var angularVel:float = 2.0
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

var previous_speed = 0

func _ready() -> void:
	area_3d.monitoring = false
	await get_tree().create_timer(0.3).timeout
	area_3d.monitoring = true

func _physics_process(_delta: float) -> void:
	if abs(linear_velocity.length() - previous_speed) > 0.1:
		audio_stream_player_3d.play()
	if linear_velocity == Vector3(0,0,0) && angular_velocity == Vector3(0,0,0):
		set_physics_process(false)
	previous_speed = linear_velocity.length()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleWheel3D:
		audio_stream_player_3d.play()
		var originalSlip = body.wheel_friction_slip
		var directionX = 1 if randi() % 2 == 0 else -1
		var directionZ = 1 if randi() % 2 == 0 else -1
		body.wheel_friction_slip -= Vector3(nailStrength * directionX, 0, nailStrength * directionZ)
		body.get_parent().angular_velocity = Vector3(angularVel * directionX, 0, angularVel * directionZ)
		area_3d.monitoring = false
		await get_tree().create_timer(1).timeout
		body.wheel_friction_slip = originalSlip
		queue_free()
	elif body is VehicleBody3D:
		audio_stream_player_3d.play()
		var directionX = 2 if randi() % 2 == 0 else -2
		var directionZ = 1 if randi() % 2 == 0 else -1
		body.angular_velocity = Vector3(angularVel * directionX, 0, angularVel * directionZ)
		area_3d.monitoring = false
		await get_tree().create_timer(1).timeout
		queue_free()

func _on_failsafe_timeout() -> void:
	queue_free()
