extends Label3D

func _process(_delta: float) -> void:
	look_at(get_viewport().get_camera_3d().global_position)
	rotate_y(230)

#@rpc("any_peer")
#func _on_multiplayer_synchronizer_synchronized() -> void:
	#Global.notify.emit("Received by peer: " + str(multiplayer.multiplayer_peer))
	#if !multiplayer.is_server(): return

@rpc("any_peer")
func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	if !multiplayer.is_server(): return
	Global.setUsername.emit(get_multiplayer_authority(), text)
