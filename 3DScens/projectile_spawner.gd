extends MultiplayerSpawner

func _ready():
	Global.connect("spawnProjectile", spawnProjectile)

func spawnProjectile(p:ProjectileClass):
	get_node(spawn_path).call_deferred("add_child", p)
	spawn(p)
