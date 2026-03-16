extends LineEdit


func _ready() -> void:
	match randi() % 5:
		0:
			text = "Carlos Eduardo"
		1:
			text = "Ikki"
		2:
			text = "Arthur"
		3:
			text = "Maicon.ZIP"
		4:
			text = "oeI"
		_:
			text = "Segmentation Fault"
	Global.username = text


func _on_text_changed(new_text: String) -> void:
	Global.username = new_text
