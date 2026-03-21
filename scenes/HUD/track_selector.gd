extends Control
@onready var main_3d: Node3D = $"../.."
@onready var track_spawner: MultiplayerSpawner = $".."
@onready var tracks_container: GridContainer = $VBoxContainer/tracksContainer

func _ready() -> void:
	visible = false
	for t in track_spawner.get_spawnable_scene_count():
		var b = Button.new()
		b.text = str(t)
		b.set_custom_minimum_size(Vector2(75, 75))
		tracks_container.add_child(b)
		b.pressed.connect(on_press.bind(b.text))

func on_press(id):
	#track_spawner.changeTrackTo(int(id))
	main_3d.prepareRace(int(id))
	visible = false

func _input(event: InputEvent) -> void:
	if multiplayer.is_server() && event.is_action("play"):
		visible = true
