extends Control
@onready var player_list: VBoxContainer = $playerList

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_disconnected)

func addPlayer(playerName:String = "Nameless"):
	var h = HBoxContainer.new()
	var l = Label.new()
	l.text = playerName
	h.alignment = BoxContainer.ALIGNMENT_CENTER
	h.add_child(l)
	h.add_child(Label.new())
	player_list.add_child(h)

func _on_disconnected(id:int):
	for c in player_list.get_children():
		if c.get_child(0).text.to_int() == id:
			c.queue_free()
			return

# Showing Ping attempt, couldn't find a way to get MS from all peers
#func _process(delta: float) -> void:
	#if !multiplayer.is_server(): return
	#ENetPacketPeer.PeerStatistic.PEER_ROUND_TRIP_TIME
	#for c in player_list.get_children():
		#if c.get_child(0).text.to_int() == multiplayer.get_peers():
			#c.queue_free()
			#return
