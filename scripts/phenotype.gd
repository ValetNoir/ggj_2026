class_name Phenotype
extends Resource

@export var mouth: Description.Mouth
@export var shape: Description.Shape
@export var horns: bool
@export var crest: bool

@export var SILHOUTTE_TEXTURE: CompressedTexture2D = null
@export var MOUTH_TEXTURE: CompressedTexture2D = null
@export var HORNS_TEXTURE: CompressedTexture2D = null
@export var EMOTIONS_TEXTURES: Dictionary[Description.Emotion, CompressedTexture2D] = {}

func _init():
	mouth = Description.Mouth.SNOUT
	shape = Description.Shape.PEAR
	horns = false
	crest = false
