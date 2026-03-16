extends ProjectileClass

func _on_area_3d_body_entered(_body: Node3D) -> void:
	get_parent().spawnProjectile(Global.Spells.BLAST, global_transform)
	queue_free()
