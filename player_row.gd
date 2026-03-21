extends HBoxContainer
class_name PlayerRowClass
@export var checkpointsHit:int = 0
var peerId:int = 1
@export var playerName:String = "Nameless"
@onready var lbl_player: Label = $HBoxContainer/lblPlayer
@onready var ms: Label = $HBoxContainer/ms

signal checkpointsHitUpdated

func _ready() -> void:
	#set_multiplayer_authority(peerId)
	Global.connect("checkpointHit", checkpointHit)
	lbl_player.text = playerName

func checkpointHit():
	checkpointsHit += 1
	checkpointsHitUpdated.emit()
	get_parent().orderChildren.rpc()

func setMs(ping:String = "This is a bug"):
	ms.text = ping + "ms"

func setName(newName:String):
	lbl_player.text = newName
	playerName = newName
