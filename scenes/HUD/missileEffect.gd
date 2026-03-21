extends EffectClass
class_name SpawnProjectileEffectClass

@export var projectileType:Global.Spells = Global.Spells.MISSILE

func activate(body:VehicleBody3D):
	body.get_parent().spawnProjectile(projectileType, body.drop.global_transform)
	super(body)
