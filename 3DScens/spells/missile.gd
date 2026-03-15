extends ProjectileClass
const BLAST = preload("uid://d4m6mag25mlme")
@onready var area_3d: Area3D = $Area3D

func _on_area_3d_body_entered(_body: Node3D) -> void:
	var b = BLAST.instantiate() as BlastClass
	b.global_transform = global_transform
	#get_tree().root.add_child(b)
	get_parent().spawnProjectile(Global.Spells.BLAST, global_transform)
	queue_free()
