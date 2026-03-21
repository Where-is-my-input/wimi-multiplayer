extends ProjectileClass

func _on_area_3d_body_entered(_body: Node3D) -> void:
	get_parent().spawnProjectile(Global.Spells.BLAST, global_transform)
	queue_free()

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _on_audio_stream_player_3d_finished() -> void:
	audio_stream_player_3d.play()
