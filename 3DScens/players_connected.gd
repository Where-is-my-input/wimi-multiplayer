extends Control
@onready var player_list: VBoxContainer = $playerList
const PLAYER_ROW = preload("uid://bsbtjl7iuf1rp")
@onready var player_list_spawner: MultiplayerSpawner = $playerListSpawner

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_disconnected)
	multiplayer.peer_connected.connect(_onConnected)
	Global.connect("setUsername", setUsernameLabel)
	Global.connect("checkpointHit", checkpointHit)

func _onConnected(id:int):
	if !multiplayer.is_server(): return
	addPlayer(str(id), id)

func addPlayer(playerName:String = "Nameless", peerId:int = 0):
	if !multiplayer.is_server(): return
	for c in player_list.get_children():
		if c.get_child(0).get_child(0).text == playerName: return
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
		if c.get_child(0).get_child(0).text == str(peerId):
			c.get_child(0).get_child(0).text = username

func checkpointHit(peerId:int):
	for c in player_list.get_children():
		if c.peerId == peerId:
			c.checkpointsHit += 1
	orderChildren.rpc()

@rpc("call_local")
func orderChildren():
	var children = player_list.get_children()
	children.sort_custom(comparator)
	for c in children:
		player_list.move_child(c, player_list.get_child_count() - 1)

func comparator(a, b):
	if a.checkpointsHit > b.checkpointsHit:
		return true
	return false

func resetCheckpointCount():
	for c in player_list.get_children():
		c.checkpointsHit = 0

func _on_ms_checker_timeout() -> void:
	#if !multiplayer.is_server(): return
	var Enet_Multiplayer: = multiplayer.multiplayer_peer
	#var multiplayerPeers = multiplayer.
	for c in player_list.get_children():
		var Enet_Peer : ENetPacketPeer = Enet_Multiplayer.get_peer(c.peerId)
		if Enet_Peer == null: 
			if c.peerId == 1: c.setMs("0")
			continue
		var Client_Ping : float = Enet_Peer.get_statistic(ENetPacketPeer.PEER_LAST_ROUND_TRIP_TIME)
		c.setMs(str(Client_Ping))
		#for p in peers:
			#Global.notify.emit(str(p))
			#var ping = p.get_statistic(ENetPacketPeer.PEER_LAST_ROUND_TRIP_TIME)
			#c.setMs(str(ping))
			#Global.notify.emit(str(ping))
			#break
