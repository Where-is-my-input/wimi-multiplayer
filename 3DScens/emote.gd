extends AnimatedSprite3D

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
