extends SubViewportContainer

var body:VehicleBody3D
@onready var camera_handler: Node3D = $SubViewport/cameraHandler
@onready var camera_3d: Camera3D = $SubViewport/cameraHandler/Camera3D
@onready var placing: Label = $placing

var place:String = "1st"

func _ready() -> void:
	placing.text = place
	if body == null:
		set_process(false)

func _process(_delta: float) -> void:
	camera_3d.look_at(body.global_position)
	camera_handler.global_position = body.global_position
