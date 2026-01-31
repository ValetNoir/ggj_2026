extends Node2D

@export var speed: float = 100.0
var _destination: Vector2 = Vector2.ZERO
var _is_moving: bool = false
const MIN_TIMER_DURATION: float = 0.8
const MAX_TIMER_DURATION: float = 1.2
const MIN_DESTINATION_DISTANCE: float = 100.0
const MAX_DESTINATION_DISTANCE: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_timer_to_next_move()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (_is_moving):
		_move(delta)
	

func _move(delta: float) -> void:
	global_position = global_position.move_toward(_destination, speed * delta)
	if global_position.is_equal_approx(_destination):
		_is_moving = false
		_set_timer_to_next_move()

func _start_move() -> void:
	var distance: float = randf_range(MIN_DESTINATION_DISTANCE, MAX_DESTINATION_DISTANCE)
	_destination = global_position + distance * _random_vector2_on_unit_circle() 
	_destination = _destination.clamp(get_viewport_rect().position,\
				get_viewport_rect().position + get_viewport_rect().size )
	_is_moving = true
	
func _random_vector2_on_unit_circle() -> Vector2:
	return Vector2.RIGHT.rotated(randf_range(0, TAU))



func _set_timer_to_next_move() -> void:
	var timer_duration = randf_range(MIN_TIMER_DURATION, MAX_TIMER_DURATION)
	var timer := get_tree().create_timer(timer_duration)
	timer.timeout.connect(_start_move)

func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) ->void:
	if event is InputEventMouseButton and event.is_pressed():
		print("clicked %s", name)
		viewport.set_input_as_handled()
