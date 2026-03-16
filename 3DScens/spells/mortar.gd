extends ProjectileClass
@onready var area_3d: Area3D = $Area3D

@export var gravityStrength:float = 0.005
@export var gravityThreshhold:float = -275

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	direction.y = 100
	area_3d.monitoring = false
	await get_tree().create_timer(0.1).timeout
	area_3d.monitoring = true

func _on_area_3d_body_entered(_body: Node3D) -> void:
	get_parent().spawnProjectile(Global.Spells.BIG_BLAST, global_transform)
	queue_free()

func _physics_process(delta: float) -> void:
	direction.y = direction.y - (gravity * gravityStrength) if direction.y > gravityThreshhold else gravityThreshhold
	super(delta)
