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
			child.texture = heart_container

func strike():
	for child in heart_container.get_children():
		if child is TextureRect and child.texture == intact_heart_texture:
			child.texture == broken_heart_texture
			return
