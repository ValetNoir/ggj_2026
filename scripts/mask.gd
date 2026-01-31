class_name Mask
extends Node2D

@export var description: Description;

@onready var shape: Sprite2D = $Shape
@onready var mouth: Sprite2D = $Mouth
@onready var emotion: Sprite2D = $Emotion
@onready var horns: Sprite2D = $Horns

func _ready() -> void:
	set_description()

func set_outline(value: bool) -> void:
	shape.material.set_shader_parameter("is_outline_on", value)
	
func set_description(_description = description):
	description = _description
	
	var phenotype = description.get_phenotype()
	
	shape.texture = phenotype.SILHOUTTE_TEXTURE
	mouth.texture = phenotype.MOUTH_TEXTURE
	
	if phenotype.horns and phenotype.HORNS_TEXTURE:
		horns.texture = phenotype.HORNS_TEXTURE
	else:
		horns.texture = null

	emotion.texture = description.get_emotion_texture()
	shape.material.set_shader_parameter("mask_color", description.get_color())
	shape.material.set_shader_parameter("overlay_tex", description.get_pattern_texture())
