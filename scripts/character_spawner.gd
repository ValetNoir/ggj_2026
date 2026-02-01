class_name CharacterSpawner
extends Node2D

@onready var _character_scene = preload("res://scenes/character.tscn")
@export var number_to_generate: int = 20
@export var max_similarity: int = 1
@export var character_spriteframes: Array[SpriteFrames]
var _spawn_rect: Rect2 = Rect2()
const _spawn_margin: float = 250.0

signal target_found
signal wrong_character_clicked

func _ready() -> void:
	_spawn_rect = get_viewport_rect().grow(-1.0 * _spawn_margin)
	
func spawn_level(level: Level) -> void:
	for child in get_children():
		child.queue_free()
	number_to_generate = level.npc_count
	max_similarity = level.max_similarity
	DescriptionMaker.generate_descriptions(number_to_generate, max_similarity)
	
	spawn(DescriptionMaker.target_description)
	for desc in DescriptionMaker.descriptions_list:
		spawn(desc)

func spawn(description: Description) -> void:
	var spawn_position := Vector2(randf_range(_spawn_rect.position.x, _spawn_rect.end.x),
					randf_range(_spawn_rect.position.y, _spawn_rect.end.y))
	var character: Character = _character_scene.instantiate()
	assert(is_instance_valid(character), "Invalid character")
	character.global_position = spawn_position
	add_child(character)
	character = character as Character
	character._set_character_spriteframe(character_spriteframes[randi_range(0, character_spriteframes.size() - 1)])
	character._mask.set_description(description)
	character.character_clicked.connect(_on_character_clicked)
	character._valid_rect = _spawn_rect;

func _on_character_clicked(desc: Description) -> void:
	if desc == DescriptionMaker.target_description:
		target_found.emit()
	else:
		wrong_character_clicked.emit()
