extends Node3D
#const FALLING_SPARK = preload("uid://cyplhep6g1su5")
#@onready var timer: Timer = $Timer
@onready var cpu_particles_3d: CPUParticles3D = $CPUParticles3D
@onready var cpu_particles_3d_2: CPUParticles3D = $CPUParticles3D2

#func _ready() -> void:
	#for c in get_parent().linear_velocity.length():
		#var s = FALLING_SPARK.instantiate()
		#s.color = Color(233, 0, 0) if randi() % 2 == 1 else Color(1.0, 0.329, 0.063, 1.0)
		#s.linearVelocity = get_parent().linear_velocity
		#add_child(s)
		#await get_tree().create_timer(0.01).timeout
	#timer.start(10)

func _on_timer_timeout() -> void:
	queue_free()

func _ready() -> void:
	cpu_particles_3d.emitting = true
	cpu_particles_3d_2.emitting = true
