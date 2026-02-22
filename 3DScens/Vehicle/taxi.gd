extends VehicleBody3D

@export var maxSteer = 0.8
@export var enginePower = 3000

func _physics_process(delta: float) -> void:
	#print(global_position)
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * maxSteer, delta * 2.5)
	engine_force = Input.get_axis("ui_down", "ui_up") * enginePower
	print(steering, " - ", engine_force, " - ", global_position)
