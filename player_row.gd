extends HBoxContainer
class_name PlayerRowClass
@onready var lbl_player: Label = $lblPlayer
@export var checkpointsHit:int = 0
var peerId:int = 1
@export var playerName:String = "Nameless"

signal checkpointsHitUpdated

func _ready() -> void:
	#set_multiplayer_authority(peerId)
	Global.connect("checkpointHit", checkpointHit)
	lbl_player.text = playerName

func checkpointHit():
	checkpointsHit += 1
	checkpointsHitUpdated.emit()
	get_parent().orderChildren.rpc()
