extends Node

signal startRace
signal notify
signal spawnProjectile
signal spawnMissile

enum Spells{
	MISSILE,
	BOOST,
	PARRY,
	BLAST
}

enum CameraType {
	DEFAULT,
	EXTERIOR,
	INTERIOR,
	TOP_DOWN,
	MAX,  # Represents the size of the CameraType enum.
}

var currentCamera:CameraType = CameraType.EXTERIOR

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		get_tree().change_scene_to_file("res://3DScens/main_3d.tscn")
	elif event.is_action_pressed("credits"):
		get_tree().change_scene_to_file("res://credits.tscn")
