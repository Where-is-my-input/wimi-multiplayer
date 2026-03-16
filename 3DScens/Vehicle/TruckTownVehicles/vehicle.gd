extends VehicleBody3D
class_name CarBodyClass
@onready var set_respawn_timer: Timer = $setRespawnTimer
const MISSILE = preload("uid://dao4ok5uv6imf")
@onready var gun: Marker3D = $gun
@onready var player_hud: Control = $"../playerHUD"
@onready var respawn_cooldown: Timer = $respawnCooldown
const PARRY = preload("uid://cd7e28n831lit")
@onready var projectile_spawner: MultiplayerSpawner = $"../projectileSpawner"
const BOOST_VFX = preload("uid://dy8royi8in62h")
const LITTLE_BLAST = preload("uid://c112ualpvwrab")
const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4
const BRAKE_STRENGTH = 2.0

@export var engine_force_value := 40.0
@export var brakeForce: float = 2

var spawnPos:Transform3D
var previous_speed := linear_velocity.length()
var _steer_target := 0.0

@onready var desired_engine_pitch: float = $EngineSound.pitch_scale

func _ready() -> void:
	#set_multiplayer_authority(name.to_int())
	spawnPos = global_transform

func _physics_process(delta: float):
	#var fwd_mps := (linear_velocity * transform.basis).x

	_steer_target = Input.get_axis("ui_right", "ui_left")
	_steer_target *= STEER_LIMIT

	# Engine sound simulation (not realistic, as this car script has no notion of gear or engine RPM).
	if isOnFloor() || Input.is_action_pressed("ui_up"):
		desired_engine_pitch = 0.05 + linear_velocity.length() / (engine_force_value * 0.5)
	else:
		desired_engine_pitch = 0.05 / (engine_force_value * 0.5)
	# Change pitch smoothly to avoid abrupt change on collision.
	$EngineSound.pitch_scale = lerpf($EngineSound.pitch_scale, desired_engine_pitch, 0.2)

	if abs(linear_velocity.length() - previous_speed) > 1.0 && isOnFloor():
		# Sudden velocity change, likely due to a collision. Play an impact sound to give audible feedback,
		# and vibrate for haptic feedback.
		$ImpactSound.play()
		Input.vibrate_handheld(100)
		for joypad in Input.get_connected_joypads():
			Input.start_joy_vibration(joypad, 0.0, 0.5, 0.1)

	# Automatically accelerate when using touch controls (reversing overrides acceleration).
	if DisplayServer.is_touchscreen_available() or Input.is_action_pressed("ui_up"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		var speed := linear_velocity.length()
		if speed < 5.0 and not is_zero_approx(speed):
			engine_force = clampf(engine_force_value * 5.0 / speed, 0.0, 100.0)
		else:
			engine_force = engine_force_value

		if not DisplayServer.is_touchscreen_available():
			# Apply analog throttle factor for more subtle acceleration if not fully holding down the trigger.
			engine_force *= Input.get_action_strength("ui_up")
	else:
		engine_force = 0.0

	if Input.is_action_pressed("ui_down"):
		# Increase engine force at low speeds to make the initial reversing faster.
		var speed := linear_velocity.length()
		if speed < 5.0 and not is_zero_approx(speed):
			engine_force = -clampf(engine_force_value * BRAKE_STRENGTH * 5.0 / speed, 0.0, 100.0)
		else:
			engine_force = -engine_force_value * BRAKE_STRENGTH

		# Apply analog brake factor for more subtle braking if not fully holding down the trigger.
		engine_force *= Input.get_action_strength("ui_down")

	steering = move_toward(steering, _steer_target, STEER_SPEED * delta)
	
	if Input.is_action_pressed("ui_accept"):
		brake = 1.3
		engine_force = 0
	else:
		brake = 0
	previous_speed = linear_velocity.length()


func _input(event: InputEvent) -> void:
	if !is_multiplayer_authority(): return
	if event.is_action_pressed("respawn"):
		respawn(null)
	elif event.is_action_pressed("forceRespawn"):
		respawn(null, true)
		Global.notify.emit("Forcing respawn")
	elif event.is_action_pressed("use0"):
		player_hud.useCard(0)
		#shootMissile.rpc()
	elif event.is_action_pressed("use1"):
		player_hud.useCard(1)
	elif event.is_action_pressed("use2"):
		player_hud.useCard(2)
	elif event.is_action_pressed("use3"):
		player_hud.useCard(3)

#@rpc("call_local")
#func shootMissile():
	#return
	#var m = MISSILE.instantiate() as ProjectileClass
	#m.global_transform = gun.global_transform
	#m.speed += linear_velocity.length()
	##m.direction = Vector3(global_rotation.x, 0, global_rotation.z).normalized()
	##m.global_position = global_position
	##m.global_rotation = global_rotation
	#get_tree().root.add_child(m)
	
func respawn(respawnTo = null, forceRespawn:bool = false):
	if !respawn_cooldown.is_stopped() && !forceRespawn: 
		Global.notify.emit("Can't respawn right now")
		return
	if respawnTo is not Vector3 || respawnTo == Vector3(0,0,0):
		global_transform = spawnPos
	elif respawnTo is Transform3D:
		global_transform = respawnTo
	else:
		global_position = respawnTo
	linear_velocity = Vector3(1, 1, 1)
	#rotation = Vector3(0, 0, 0)
	setRespawnCooldown()
	#global_rotation = Vector3(0,0,0)

func setRespawnCooldown(value:float = 5):
	respawn_cooldown.start(value)

func _on_set_respawn_timer_timeout() -> void:
	#print("timer ", spawnPos)
	if isOnFloor() && rotation.y > 0:
		spawnPos = global_transform
	set_respawn_timer.start(5)

func isOnFloor():
	for c in get_children():
		if c is VehicleWheel3D:
			#print(c)
			if !c.is_in_contact():
				return false
	return true
	
func parry():
	for c in get_children():
		if c is ParryClass:
			c.queue_free()
			await get_tree().create_timer(0.5).timeout
	var p = PARRY.instantiate()
	#projectile_spawner.spawn(p)
	add_child(p)

func blast():
	var p = LITTLE_BLAST.instantiate()
	#projectile_spawner.spawn(p)
	add_child(p)

func boost(boostStrength:float = 1.1):
	linear_velocity *= boostStrength
	add_child(BOOST_VFX.instantiate())

func raceFinished():
	set_physics_process(false)
