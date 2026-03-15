extends MultiplayerSpawner
const MISSILE = preload("uid://dao4ok5uv6imf")
const BLAST = preload("uid://d4m6mag25mlme")

func _ready():
	#Global.connect("spawnProjectile", spawnMissile)
	spawn_function = Callable(self, "spawnProjectile")
#
func spawnProjectile(data:Variant):
	#get_node(spawn_path).call_deferred("add_child", p)
	var m
	match data["spell"]:
		Global.Spells.BLAST:
			m = BLAST.instantiate()
			m.global_transform = data["globalTransform"]
		_:
			m = MISSILE.instantiate()
			m.global_transform = get_parent().body.gun.global_transform
			#m.global_transform = get_node(spawn_path).gun.global_transform if is_multiplayer_authority() else get_node(data["body"]).gun.global_transform
			m.speed += get_parent().body.linear_velocity.length()
	return m
#
#func spawnMissile(body:VehicleBody3D):
	#var m = load(get_spawnable_scene(0)).instantiate() as ProjectileClass
	#m.global_transform = body.gun.global_transform
	#m.speed += body.linear_velocity.length()
	#get_node(spawn_path).call_deferred("add_child", m)
