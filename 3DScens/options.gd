extends Control
@onready var bgm: CheckBox = $BGM

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mute"):
		bgm.button_pressed = !bgm.button_pressed
		_on_bgm_toggled(bgm.button_pressed)

func _on_bgm_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)
