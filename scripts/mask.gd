extends Node2D

@export var description: Description;

@onready var shape: Sprite2D = $Shape
@onready var mouth: Sprite2D = $Mouth
@onready var emotion: Sprite2D = $Emotion
@onready var horns: Sprite2D = $Horns

func _ready() -> void:
	shape.texture = description.phenotype.SILHOUTTE_TEXTURE
	mouth.texture = description.phenotype.MOUTH_TEXTURE
	
	if description.phenotype.horns:
		horns.texture = description.phenotype.HORNS_TEXTURE

	emotion.texture = description.phenotype.EMOTIONS_TEXTURES[description.emotion]
	shape.material.set_shader_parameter("color", description.COLORS[description.color])
	
