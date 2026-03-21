extends AnimatedSprite3D
class_name EmoteClass

enum Type{
	ANGRY,
	BROKEN,
	HAPPY,
	HEART,
	LAUGH,
	QUESTION,
	SAD
}

@export var emoteType:Type = Type.QUESTION

func _ready():
	lookAtTheCameraAndRotate()
	match emoteType:
		Type.ANGRY:
			play("angry")
		Type.BROKEN:
			play("brokenHeart")
		Type.HAPPY:
			play("happy")
		Type.HEART:
			play("heart")
		Type.LAUGH:
			play("laugh")
		Type.QUESTION:
			play("question")
		Type.SAD:
			play("sad")


func _on_despawn_timeout() -> void:
	queue_free()

func _process(_delta: float) -> void:
	lookAtTheCameraAndRotate()

func lookAtTheCameraAndRotate():
	var cameraPos = get_viewport().get_camera_3d().global_position
	look_at(cameraPos)
	#look_at_from_position(Vector3(global_position.x, cameraPos.y - position.y, global_position.z), cameraPos)
	rotate_y(230)
