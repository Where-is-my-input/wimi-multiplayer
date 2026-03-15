extends MultiplayerSpawner
@onready var track: Node = $"../track"

var currentTrack:int = 3

func _ready() -> void:
	loadTrack()

func incrementCurrentTrack():
	currentTrack += 1
	if currentTrack >= get_spawnable_scene_count(): currentTrack = 0

func loadTrack():
	unloadTrack()
	var trackToLoad = load(get_spawnable_scene(currentTrack))
	track.add_child(trackToLoad.instantiate())
	incrementCurrentTrack()

func unloadTrack():
	for c in track.get_children():
		c.queue_free()
