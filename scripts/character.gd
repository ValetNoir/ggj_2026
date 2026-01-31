extends Node2D

@onready var _area: Area2D = $Area2D

@export var speed: float = 100.0
var _destination: Vector2 = Vector2.ZERO
var _is_moving: bool = false
var _valid_rect: Rect2 = Rect2()
const MIN_TIMER_DURATION: float = 0.7
const MAX_TIMER_DURATION: float = 1.2
const MIN_DESTINATION_DISTANCE: float = 100.0
const MAX_DESTINATION_DISTANCE: float = 200.0
const MIN_START_DELAY: float = 0.1
const MAX_START_DELAY: float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_valid_rect = get_viewport_rect().grow(-30.0)
	get_tree().create_timer(randf_range(MIN_START_DELAY, MAX_START_DELAY))\
		.timeout.connect(_start_move)

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
	var direction: Vector2 = _get_move_direction()
	_destination = global_position + distance * direction 
	_destination = _reflect_destination(_destination)
	print("%s move to %s", [name, _destination])
	_is_moving = true

func _reflect_destination(destination: Vector2) -> Vector2:
	if destination.x < _valid_rect.position.x:
		destination.x = _valid_rect.position.x +\
			(_valid_rect.position.x - destination.x)
	if destination.x > _valid_rect.end.x:
		destination.x = _valid_rect.end.x -\
			(destination.x - _valid_rect.end.x)
	if destination.y < _valid_rect.position.y:
		destination.y = _valid_rect.position.y +\
			(_valid_rect.position.y - destination.y)
	if destination.y > _valid_rect.end.y:
		destination.y = _valid_rect.end.y -\
			(destination.y - _valid_rect.end.y)
	
	return destination

func _get_move_direction() -> Vector2:
	var average: Vector2 = _get_average_of_overlaps_positions()
	var direction: Vector2 = Vector2.ZERO
	if (average.is_equal_approx(Vector2.ZERO)):
		direction = _random_vector2_on_unit_circle()
	else:
		direction = (global_position - average).normalized()
	return direction
	
func _random_vector2_on_unit_circle() -> Vector2:
	return Vector2.RIGHT.rotated(randf_range(0, TAU))

func _get_average_of_overlaps_positions() -> Vector2:
	var overlaps: Array[Area2D] = _area.get_overlapping_areas()
	var overlap_count = overlaps.size()
	if (overlap_count == 0):
		return Vector2.ZERO
	var average_position = Vector2.ZERO
	for area in overlaps:
		average_position += area.global_position
	average_position /= overlap_count
	return average_position

func _set_timer_to_next_move() -> void:
	var timer_duration = randf_range(MIN_TIMER_DURATION, MAX_TIMER_DURATION)
	var timer := get_tree().create_timer(timer_duration)
	timer.timeout.connect(_start_move)

func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) ->void:
	if event is InputEventMouseButton and event.is_pressed():
		print("clicked %s", name)
		viewport.set_input_as_handled()
