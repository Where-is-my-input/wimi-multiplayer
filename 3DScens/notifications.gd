extends Control
@onready var not_box: VBoxContainer = $notBox

func _ready() -> void:
	Global.connect("notify", notify)

func notify(text:String):
	print(text)
	set_deferred("visible", true)
	var l = Label.new()
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.text = text
	not_box.add_child(l)
	await get_tree().create_timer(5).timeout
	l.queue_free()
	verifyNotifications()

func verifyNotifications():
	for c in not_box.get_children():
		return
	set_deferred("visible", false)
