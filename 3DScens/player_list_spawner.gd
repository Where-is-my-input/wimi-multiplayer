extends MultiplayerSpawner
const PLAYER_ROW = preload("uid://bsbtjl7iuf1rp")

func _ready():
	spawn_function = Callable(self, "spawnPlayerRow")

func spawnPlayerRow(data:Variant):
	var pr = PLAYER_ROW.instantiate()
	pr.playerName = data["playerName"]
	pr.peerId = data["peerId"]
	return pr
