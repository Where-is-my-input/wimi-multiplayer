extends HBoxContainer
class_name PlayerRowClass
@onready var lbl_player: Label = $lblPlayer

var peerId:int
@export var playerName:String = "Nameless"

func _ready() -> void:
	lbl_player.text = playerName
