class_name Phenotype
extends Resource

@export var species: Description.Species
@export var mouth: Description.Mouth
@export var shape: Description.Shape
@export var horns: bool
@export var crest: bool

@export var SILHOUTTE_TEXTURES: CompressedTexture2D = null
@export var FACE_TEXTURE: CompressedTexture2D = null
@export var HORNS_TEXTURES: CompressedTexture2D = null
@export var EMOTIONS_TEXTURES: Dictionary[Description.Emotion, CompressedTexture2D] = {}
static var EYES_TEXTURE: CompressedTexture2D = preload("uid://d3v8eynat77lb")

func _init():
	species = Description.Species.DIPLODOCUS
	mouth = Description.Mouth.SNOUT
	shape = Description.Shape.PEAR
	horns = false
	crest = false
