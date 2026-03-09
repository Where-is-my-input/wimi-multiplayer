extends Control
@onready var player_list: VBoxContainer = $playerList

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_disconnected)

func addPlayer(playerName:String = "Nameless"):
	var l = Label.new()
	l.text = playerName
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	player_list.add_child(l)

func _on_disconnected(id:int):
	for c in player_list.get_children():
		if c.text.to_int() == id:
			c.queue_free()
			return
