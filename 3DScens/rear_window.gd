extends SubViewportContainer

func _ready() -> void:
	setCamera()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("changeRearCamera"):
		@warning_ignore("int_as_enum_without_cast")
		Global.currentRearCamera += 1
		setCamera()

func setCamera():
	match Global.currentRearCamera:
		Global.RearCameraType.BIG:
			size = Vector2(584.214, 151.0)
			position = Vector2(298.0, 15.0)
		Global.RearCameraType.HIDDEN:
			visible = false
		Global.RearCameraType.SMALL:
			visible = true
			size = Vector2(328.862, 85.0)
			position = Vector2(426.0, 12.0)
		_:
			visible = true
			size = Vector2(328.862, 85.0)
			position = Vector2(426.0, 12.0)
			Global.currentRearCamera = Global.RearCameraType.SMALL
