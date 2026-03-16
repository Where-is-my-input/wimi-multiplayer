extends Node

signal startRace
signal notify
signal spawnProjectile
signal spawnMissile
signal setUsername
signal setWinner

enum Spells{
	MISSILE,
	BOOST,
	PARRY,
	BLAST,
	BIG_BLAST,
	MORTAR
}

enum Cards{
	MISSILE,
	BOOST,
	PARRY,
	BLAST,
	MORTAR
}

enum CameraType {
	DEFAULT,
	EXTERIOR,
	INTERIOR,
	TOP_DOWN,
	MAX,  # Represents the size of the CameraType enum.
}

var currentCamera:CameraType = CameraType.EXTERIOR
var username:String = "Random Username"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		get_tree().change_scene_to_file("res://3DScens/main_3d.tscn")
	elif event.is_action_pressed("credits"):
		get_tree().change_scene_to_file("res://credits.tscn")

@rpc("any_peer", "call_local", "reliable")
func spawnWinnerCam(peerId:int):
	setWinner.emit(peerId)
