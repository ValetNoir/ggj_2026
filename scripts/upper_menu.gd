class_name UpperMenu
extends Control

@export var intact_heart_texture: Texture2D
@export var broken_heart_texture: Texture2D

@onready var heart_container: HBoxContainer = %HeartContainer

func _ready():
	reset()

func reset():
	for child in heart_container.get_children():
		if child is TextureRect:
			child.texture = intact_heart_texture
	show()

func strike():
	var array: Array = heart_container.get_children()
	array.reverse()
	for child in array:
		if child is TextureRect and child.texture == intact_heart_texture:
			child.texture = broken_heart_texture
			SignalBus.play_sfx.emit(SignalBus.SFX.STRIKE_WRONG)
			return

func gain_life():
	var array: Array = heart_container.get_children()
	array.reverse()
	for child in array:
		if child is TextureRect and child.texture == broken_heart_texture:
			child.texture = intact_heart_texture
			SignalBus.play_sfx.emit(SignalBus.SFX.STRIKE_CORRECT)
			return
