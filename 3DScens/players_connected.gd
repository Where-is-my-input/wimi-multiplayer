extends Control
@onready var player_list: VBoxContainer = $playerList
const PLAYER_ROW = preload("uid://bsbtjl7iuf1rp")
@onready var player_list_spawner: MultiplayerSpawner = $playerListSpawner

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_disconnected)
	multiplayer.peer_connected.connect(_onConnected)
	Global.connect("setUsername", setUsernameLabel)

#@rpc("any_peer")
func _onConnected(id:int):
	if !multiplayer.is_server(): return
	#return
	addPlayer(str(id), id)

func addPlayer(playerName:String = "Nameless", peerId:int = 0):
	if !multiplayer.is_server(): return
	for c in player_list.get_children():
		if c.get_child(0).text == playerName: return
	var data = {playerName = playerName, peerId = peerId}
	player_list_spawner.spawn(data)

func _on_disconnected(id:int):
	Global.notify.emit("Peer " + str(id) + " disconnected")
	for c in player_list.get_children():
		Global.notify.emit("looking " + str(c.peerId) + " peer")
		if c.peerId == id:
			Global.notify.emit("Label " + str(c.peerId) + " found")
			c.queue_free()

func setUsernameLabel(peerId:int, username:String):
	for c in player_list.get_children():
		if c.get_child(0).text == str(peerId):
			c.get_child(0).text = username

# Showing Ping attempt, couldn't find a way to get MS from all peers
#func _process(delta: float) -> void:
	#if !multiplayer.is_server(): return
	#ENetPacketPeer.PeerStatistic.PEER_ROUND_TRIP_TIME
	#for c in player_list.get_children():
		#if c.get_child(0).text.to_int() == multiplayer.get_peers():
			#c.queue_free()
			#return
