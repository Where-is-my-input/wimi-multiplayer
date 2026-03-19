extends SubViewportContainer

enum rearCameraType{
	DEFAULT,
	BIG,
	HIDDEN
}

var currentCamera:rearCameraType = rearCameraType.DEFAULT

func _ready() -> void:
	setCamera()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("changeRearCamera"):
		@warning_ignore("int_as_enum_without_cast")
		currentCamera += 1
		setCamera()

func setCamera():
	match currentCamera:
		rearCameraType.BIG:
			size = Vector2(584.214, 151.0)
			position = Vector2(298.0, 15.0)
		rearCameraType.HIDDEN:
			visible = false
		rearCameraType.DEFAULT:
			visible = true
			size = Vector2(328.862, 85.0)
			position = Vector2(426.0, 12.0)
		_:
			visible = true
			size = Vector2(328.862, 85.0)
			position = Vector2(426.0, 12.0)
			currentCamera = rearCameraType.DEFAULT
