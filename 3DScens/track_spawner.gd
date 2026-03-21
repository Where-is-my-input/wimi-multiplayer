extends MultiplayerSpawner
@onready var track: Node = $"../track"

var currentTrack:int = 0

func incrementCurrentTrack():
	currentTrack += 1
	if currentTrack >= get_spawnable_scene_count(): currentTrack = 0

func loadTrack():
	unloadTrack()
	await get_tree().create_timer(1).timeout
	loadTrackById(currentTrack)
	incrementCurrentTrack()

func unloadTrack():
	for c in track.get_children():
		c.queue_free()

func loadTrackById(trackId:int = 0):
	if trackId >= get_spawnable_scene_count(): return
	var trackToLoad = load(get_spawnable_scene(trackId))
	track.add_child(trackToLoad.instantiate())
	
func changeTrackTo(trackId:int = 0):
	unloadTrack()
	await get_tree().create_timer(1).timeout
	loadTrackById(trackId)
	
