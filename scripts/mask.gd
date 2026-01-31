extends Node2D

@export var description: Description;

@onready var shape: Sprite2D = $Shape
@onready var mouth: Sprite2D = $Mouth
@onready var emotion: Sprite2D = $Emotion
@onready var horns: Sprite2D = $Horns

func _ready() -> void:
	var phenotype = description.get_phenotype()
	
	shape.texture = phenotype.SILHOUTTE_TEXTURE
	mouth.texture = phenotype.MOUTH_TEXTURE
	
	if phenotype.horns:
		horns.texture = phenotype.HORNS_TEXTURE
	else:
		horns.texture = null

	emotion.texture = description.get_emotion_texture()
	shape.material.set_shader_parameter("color", description.get_color())
	
