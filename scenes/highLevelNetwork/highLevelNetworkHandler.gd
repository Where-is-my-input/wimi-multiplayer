extends Node

const IP_ADDRESS: String = "localhost"
const PORT: int = 42069

var peer: ENetMultiplayerPeer

func startServer(port:String):
	peer = ENetMultiplayerPeer.new()
	peer.create_server(port.to_int())
	multiplayer.multiplayer_peer = peer

func startClient(port:String, ip:String):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port.to_int())
	multiplayer.multiplayer_peer = peer
