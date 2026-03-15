extends Control
@onready var player_list: VBoxContainer = $playerList
const PLAYER_ROW = preload("uid://bsbtjl7iuf1rp")
@onready var player_list_spawner: MultiplayerSpawner = $playerListSpawner

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_disconnected)
	multiplayer.peer_connected.connect(_onConnected)

#@rpc("any_peer")
func _onConnected(id:int):
	if !multiplayer.is_server(): return
	#return
	addPlayer(str(id))

func addPlayer(playerName:String = "Nameless"):
	if !multiplayer.is_server(): return
	for c in player_list.get_children():
		if c.get_child(0).text == playerName: return
	var pr = PLAYER_ROW.instantiate()
	#var h = HBoxContainer.new()
	#var l = Label.new()
	pr.playerName = playerName
	#h.alignment = BoxContainer.ALIGNMENT_CENTER
	#h.add_child(l)
	#h.add_child(Label.new())
	#player_list.add_child(pr)
	var data = {playerName = playerName}
	player_list_spawner.spawn(data)

func _on_disconnected(id:int):
	for c in player_list.get_children():
		if c.get_child(0).text.to_int() == id:
			c.queue_free()

# Showing Ping attempt, couldn't find a way to get MS from all peers
#func _process(delta: float) -> void:
	#if !multiplayer.is_server(): return
	#ENetPacketPeer.PeerStatistic.PEER_ROUND_TRIP_TIME
	#for c in player_list.get_children():
		#if c.get_child(0).text.to_int() == multiplayer.get_peers():
			#c.queue_free()
			#return
