extends Node3D

var currentCheckpoint:Area3D
var firstCheckpoint:Area3D

var lap:int = 0

func _ready() -> void:
	visible = true
	var count = 0
	var previousCheckpoint:Area3D
	for c in get_children():
		c.connect("body_entered", _on_checkpoint_body_entered, 16)
		if count == 0:
			currentCheckpoint = c
		else:
			c.visible = false
		@warning_ignore("unassigned_variable")
		if previousCheckpoint == null:
			firstCheckpoint = c
			c.setAsLapStart()
		else:
			@warning_ignore("unassigned_variable")
			previousCheckpoint.nextCheckpoint = c
		previousCheckpoint = c
		count += 1
	previousCheckpoint.nextCheckpoint = firstCheckpoint


func _on_checkpoint_body_entered(body: Node3D, source: Area3D) -> void:
	if body is VehicleBody3D && body.is_multiplayer_authority():
		Global.notify.emit("Checkpoint " + str(source) + " hit")
		if source == currentCheckpoint:
			if currentCheckpoint == firstCheckpoint:
				Global.notify.emit("Lap " + str(lap) + " complete!")
				lap += 1
			currentCheckpoint.visible = false
			currentCheckpoint = source.nextCheckpoint
			currentCheckpoint.visible = true
