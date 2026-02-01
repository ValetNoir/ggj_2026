extends Node
class_name AudioManager

@export_category("Music")
@export var title_music: AudioStream
@export var game_music: AudioStream

@onready var music_audio_stream_player: AudioStreamPlayer = $MusicAudioStreamPlayer
@onready var sfx_audio_stream_player_found_target: AudioStreamPlayer = $SFXAudioStreamPlayerFoundTarget
@onready var sfx_audio_stream_player_wrong_target: AudioStreamPlayer = $SFXAudioStreamPlayerWrongTarget
@onready var sfx_audio_stream_player_strike_correct: AudioStreamPlayer = $SFXAudioStreamPlayerStrikeCorrect
@onready var sfx_audio_stream_player_strike_wrong: AudioStreamPlayer = $SFXAudioStreamPlayerStrikeWrong
@onready var sfx_audio_stream_player_hint: AudioStreamPlayer = $SFXAudioStreamPlayerHint
@onready var sfx_audio_stream_player_crowd: AudioStreamPlayer = $SFXAudioStreamPlayerCrowd
@onready var sfx_audio_stream_player_curtain_open: AudioStreamPlayer = $SFXAudioStreamPlayerCurtainOpen
@onready var sfx_audio_stream_player_curtain_close: AudioStreamPlayer = $SFXAudioStreamPlayerCurtainClose

func _ready():
	SignalBus.play_music.connect(play_music)
	SignalBus.play_sfx.connect(play_sound)

func play_music(soundtrack: SignalBus.MUSIC):
	var new_stream: AudioStream
	match soundtrack:
		SignalBus.MUSIC.TITLE:
			new_stream = title_music
		SignalBus.MUSIC.GAME:
			new_stream = game_music
	var tween = get_tree().create_tween()
	tween.tween_property(music_audio_stream_player,"volume_linear", 0.0, 1.0)
	tween.tween_callback(change_music.bind(new_stream))

func change_music(audiostream: AudioStream):
	music_audio_stream_player.stream = audiostream
	music_audio_stream_player.play()
	var tween = get_tree().create_tween()
	tween.tween_property(music_audio_stream_player,"volume_linear", 1.0, 1.0)

func play_sound(sfx: SignalBus.SFX):
	match sfx:
		SignalBus.SFX.FOUND_TARGET:
			sfx_audio_stream_player_found_target.play()
		SignalBus.SFX.WRONG_TARGET:
			sfx_audio_stream_player_wrong_target.play()
		SignalBus.SFX.STRIKE_CORRECT:
			sfx_audio_stream_player_strike_correct.play()
		SignalBus.SFX.STRIKE_WRONG:
			sfx_audio_stream_player_strike_wrong.play()
		SignalBus.SFX.OPEN_CURTAIN:
			sfx_audio_stream_player_curtain_open.play()
		SignalBus.SFX.CLOSE_CURTAIN:
			sfx_audio_stream_player_curtain_close.play()
		SignalBus.SFX.CROWD:
			sfx_audio_stream_player_crowd.play()
		SignalBus.SFX.HINT:
			sfx_audio_stream_player_hint.play()
