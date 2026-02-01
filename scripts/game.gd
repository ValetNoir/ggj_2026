extends Node2D

@export var current_level_index: int = 0
@export var levels: Array[Level]
@export var max_life: int = 4

@onready var character_spawner: CharacterSpawner = $CharacterSpawner
@onready var info_flash: InfoFlash = %InfoFlash
@onready var curtains: Curtains = $Curtains
@onready var upper_menu: UpperMenu = %UpperMenu
@onready var game_over_menu: Control = %GameOverMenu

signal level_loaded(int)

var current_life: int

func reset():
	current_life = max_life
	upper_menu.reset()
	load_level(current_level_index)
	SignalBus.play_music.emit(SignalBus.MUSIC.GAME)
	game_over_menu.hide()

func _ready() -> void:
	character_spawner.target_found.connect(_on_target_found)
	character_spawner.wrong_character_clicked.connect(_on_wrong_target)
	reset()

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
	if levels[current_level_index].gain_life and current_life < max_life:
		upper_menu.gain_life()
		current_life += 1

func show_victory_screen() -> void:
	pass

func _on_target_found() -> void:
	next_level()
	await get_tree().create_timer(0.5).timeout
	SignalBus.play_sfx.emit(SignalBus.SFX.FOUND_TARGET)

func _on_wrong_target() -> void:
	upper_menu.strike()
	current_life -= 1
	if current_life < 1:
		show_game_over_screen()
	else:
		#TODO Reshow info flash
		pass
	await get_tree().create_timer(0.5).timeout
	SignalBus.play_sfx.emit(SignalBus.SFX.WRONG_TARGET)

func show_game_over_screen():
	await curtains.close_curtains()
	game_over_menu.show()

func _on_retry_button_pressed():
	reset()
