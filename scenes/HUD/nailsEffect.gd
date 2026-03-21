extends SpawnProjectileEffectClass

@export var timerBetweenSpawns:float = 0.1

var isActive:bool = false

func activate(body:VehicleBody3D):
	if isActive: return
	isActive = true
	body.get_parent().spawnProjectile(projectileType, body.drop.global_transform)
	await get_tree().create_timer(timerBetweenSpawns).timeout
	body.get_parent().spawnProjectile(projectileType, body.drop.global_transform)
	await get_tree().create_timer(timerBetweenSpawns).timeout
	body.get_parent().spawnProjectile(projectileType, body.drop.global_transform)
	await get_tree().create_timer(timerBetweenSpawns).timeout
	body.get_parent().spawnProjectile(projectileType, body.drop.global_transform)
	await get_tree().create_timer(timerBetweenSpawns).timeout
	super(body)
