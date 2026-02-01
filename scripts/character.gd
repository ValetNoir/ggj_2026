class_name Character
extends Node2D

@onready var _area: Area2D = $Area2D
@onready var _mask: Mask = $Mask
static var _held_character: Character = null
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
const NORMAL_Z_INDEX: int = 0
const HELD_Z_INDEX: int = 1
signal character_clicked(Description)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_valid_rect = get_viewport_rect().grow(-30.0)
	get_tree().create_timer(randf_range(MIN_START_DELAY, MAX_START_DELAY))\
		.timeout.connect(_start_move)
	_area.mouse_entered.connect(_on_area_mouse_enter)
	_area.mouse_exited.connect(_on_area_mouse_exit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (_is_moving):
		_move(delta)

func _move(delta: float) -> void:
	if _held_character == self:
		return
	global_position = global_position.move_toward(_destination, speed * delta)
	if global_position.is_equal_approx(_destination):
		_is_moving = false
		_set_timer_to_next_move()

func _start_move() -> void:
	var distance: float = randf_range(MIN_DESTINATION_DISTANCE, MAX_DESTINATION_DISTANCE)
	var direction: Vector2 = _get_move_direction()
	_destination = global_position + distance * direction 
	_destination = _reflect_destination(_destination)
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
	return _random_vector2_on_unit_circle()
	
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

func _on_area_mouse_enter() -> void:
	if not is_instance_valid(_held_character):
		z_index = HELD_Z_INDEX
		_held_character = self
		_mask.set_outline(true)

func _on_area_mouse_exit() -> void:
	if _held_character == self:
		z_index = NORMAL_Z_INDEX
		_hold_next_character()

func _hold_next_character() -> void:
	_held_character._mask.set_outline(false)
	var mouse_position = get_viewport().get_mouse_position()
	var query := PhysicsPointQueryParameters2D.new()
	query.position = mouse_position
	query.collide_with_areas = true
	var intersects := get_world_2d().direct_space_state.intersect_point(query)
		
	for result:Dictionary in intersects:
		if not result.has("collider"):
			continue
		var collider: Node2D = result.collider
		if collider.get_parent() is Character:
			_held_character = collider.get_parent()
			_held_character.z_index = HELD_Z_INDEX
			_held_character._mask.set_outline(true)
			return
	# default case if no valid hit
	_held_character = null
	return


func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) ->void:
	if event is InputEventMouseButton and event.is_pressed():
		viewport.set_input_as_handled()
		character_clicked.emit(_mask.description)
