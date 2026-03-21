extends MultiplayerSpawner
const MISSILE = preload("uid://dao4ok5uv6imf")
const BLAST = preload("uid://d4m6mag25mlme")
const BIG_BLAST = preload("uid://bepfcavb1e7jy")
const MORTAR = preload("uid://beb03o8l37g1b")
const NAIL = preload("uid://3ofqkhue2xh4")
const WALL_SPELL = preload("uid://bl4haheni2554")

func _ready():
	spawn_function = Callable(self, "spawnProjectile")
#p
func spawnProjectile(data:Variant):
	var m
	match data["spell"]:
		Global.Spells.BLAST:
			m = BLAST.instantiate()
			m.global_transform = data["globalTransform"]
		Global.Spells.WALL:
			m = WALL_SPELL.instantiate()
			m.global_transform = data["globalTransform"]
		Global.Spells.NAILS:
			m = NAIL.instantiate() as RigidBody3D
			var strength = 150
			m.angular_velocity = Vector3(randi() % strength - randi() % strength, randi() % strength - randi() % strength, randi() % strength - randi() % strength)
			m.global_transform = data["globalTransform"]
		Global.Spells.BIG_BLAST:
			m = BIG_BLAST.instantiate()
			m.global_transform = data["globalTransform"]
		Global.Spells.MORTAR:
			m = MORTAR.instantiate() as CharacterBody3D
			m.global_transform = get_parent().body.gun.global_transform
			m.rotation.z = 0
			#m.rotation.x = 0
			m.speed += get_parent().body.linear_velocity.length()
		_:
			m = MISSILE.instantiate()
			m.global_transform = get_parent().body.gun.global_transform
			m.speed += get_parent().body.linear_velocity.length()
	return m
