extends MultiplayerSpawner
const WINNER_CAM = preload("uid://bberchp665sgt")
@onready var players: Node = $"../../players"
@onready var winner: Node = $".."

var placements:int = 1

func _ready():
	spawn_function = Callable(self, "spawnCamera")

func spawnCamera(data:Variant):
	var w = WINNER_CAM.instantiate()
	for c in players.get_children():
		if c.get_multiplayer_authority() == data["peerId"]:
			w.body = c.body
			w.place = getPlacement(placements)
			placements += 1
	#w.body = data["body"] if data["body"] is not EncodedObjectAsID else get_node(data["body"].object_id)
	return w

func getPlacement(placement:int = 1):
	match placement:
		1: return "1st"
		2: return "2nd"
		3: return "3rd"
		4: return "4th"
		_: return "Skill issue"

func newRace():
	resetPlacements.rpc()
	for c in winner.get_children():
		if c is MultiplayerSpawner: continue
		c.queue_free()

@rpc("any_peer", "call_local", "reliable")
func resetPlacements():
	placements = 1
