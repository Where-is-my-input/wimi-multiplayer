extends Control


func _on_bgm_toggled(toggled_on: bool) -> void:
	Global.notify.emit(str(AudioServer.get_bus_name(1)))
	AudioServer.set_bus_mute(1, !toggled_on)
