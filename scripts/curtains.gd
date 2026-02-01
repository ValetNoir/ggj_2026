class_name Curtains
extends Node2D

@export var curtains: Array[Node2D] = []

func _ready() -> void:
	pass

func close_curtains() -> void:
	SignalBus.play_sfx.emit(SignalBus.SFX.CLOSE_CURTAIN)
	await _set_curtains_closed(true)

func open_curtains() -> void:
	SignalBus.play_sfx.emit(SignalBus.SFX.OPEN_CURTAIN)
	await _set_curtains_closed(false)

func _set_curtains_closed(closed: bool) -> void:
	var target_position: Vector2 = Vector2.ZERO
	if not closed:
		target_position = Vector2.RIGHT * 1000
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	for curtain in curtains:
		tween.tween_property(curtain, "position", target_position, 1.2)
	await tween.finished
	
