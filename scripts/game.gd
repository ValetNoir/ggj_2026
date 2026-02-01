extends Node2D


@export var current_level_index: int = 0
@export var levels: Array[Level]
@onready var character_spawner: CharacterSpawner = $CharacterSpawner
@onready var info_flash: InfoFlash = %InfoFlash
@onready var curtains: Curtains = $Curtains
signal level_loaded(int)

func _ready() -> void:
	load_level(current_level_index)
	character_spawner.target_found.connect(_on_target_found)
	character_spawner.wrong_character_clicked.connect(_on_wrong_target)

func load_level(level: int) -> void:
	assert(level >= 0 and level < levels.size(), "Invalid level: %d" % level)
	character_spawner.spawn_level(levels[level])
	level_loaded.emit(level)
	await info_flash.on_new_level_diplay_info_flash(levels[level].clue_duration)
	curtains.open_curtains()

func next_level() -> void:
	current_level_index += 1
	if current_level_index >= levels.size():
		show_victory_screen()
		return
	await curtains.close_curtains()
	load_level(current_level_index)
	
	
func show_victory_screen() -> void:
	pass

func _on_target_found() -> void:
	next_level()

func _on_wrong_target() -> void:
	pass
	#upper_menu.strike()
