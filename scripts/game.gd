extends Node2D

@export var current_level_index: int = 0
@export var levels: Array[Level]
@export var max_life: int = 4

@onready var character_spawner: CharacterSpawner = $CharacterSpawner
@onready var info_flash: InfoFlash = %InfoFlash
@onready var curtains: Curtains = $Curtains
@onready var upper_menu: UpperMenu = %UpperMenu
@onready var game_over_menu: Control = %GameOverMenu
@onready var victory_menu: Control = %VictoryMenu
@onready var title_menu: Control = %TitleMenu
@onready var lore: Control = %Lore

signal level_loaded(level_index: int, levels_count: int)

enum STATE {
	LORE_ON,
	LORE_OFF
}

var current_life: int
var current_state: STATE = STATE.LORE_ON

func reset():
	title_menu.hide()
	current_life = max_life
	upper_menu.reset()
	load_level(current_level_index)
	SignalBus.play_music.emit(SignalBus.MUSIC.GAME)

func _ready() -> void:
	show_title_menu()
	character_spawner.target_found.connect(_on_target_found)
	character_spawner.wrong_character_clicked.connect(_on_wrong_target)

func _unhandled_input(event):
	if current_state == STATE.LORE_ON and (event is InputEventMouseButton or event is InputEventKey):
		current_state = STATE.LORE_OFF
		var tween = get_tree().create_tween()
		tween.tween_property(lore, "modulate", Color.TRANSPARENT, 1.0)

func load_level(level: int) -> void:
	assert(level >= 0 and level < levels.size(), "Invalid level: %d" % level)
	character_spawner.spawn_level(levels[level])
	level_loaded.emit(level, levels.size())
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
	await curtains.close_curtains()
	game_over_menu.show()

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
		await info_flash.display_info(levels[current_level_index].clue_duration)
	await get_tree().create_timer(0.5).timeout
	SignalBus.play_sfx.emit(SignalBus.SFX.WRONG_TARGET)

func show_game_over_screen():
	await curtains.close_curtains()
	victory_menu.show()

func show_title_menu():
	game_over_menu.hide()
	victory_menu.hide()
	title_menu.show()
	upper_menu.hide()
	SignalBus.play_music.emit(SignalBus.MUSIC.TITLE)
	# ...lore
	lore.show()
	lore.modulate = Color.WHITE
	current_state = STATE.LORE_ON

func _on_retry_button_pressed():
	show_title_menu()

func _on_play_button_pressed():
	reset()
