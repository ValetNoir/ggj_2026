extends Node2D


@export var current_level_index: int = 0
@export var levels: Array[Level]
@onready var character_spawner: CharacterSpawner = $CharacterSpawner
signal level_loaded(int)

func _ready() -> void:
	load_level(current_level_index)
	character_spawner.target_found.connect(_on_target_found)

func load_level(level: int) -> void:
	assert(level >= 0 and level < levels.size(), "Invalid level: %d" % level)
	character_spawner.spawn_level(levels[level])
	level_loaded.emit(level)

func next_level() -> void:
	current_level_index += 1
	load_level(current_level_index)

func _on_target_found() -> void:
	next_level()
