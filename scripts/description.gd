class_name Description
extends Resource

# Indepedent enums
enum Species {
	DIPLODOCUS,
	BRACHIOSAURUS,
	TRICERATOPS,
	PROTOCERATOPS,
	TYRANNOSAURUS,
	CERATOSAURUS,
	HADROSAURUS,
	PARASAUROLOPHUS,
	OVIRAPTOR,
}
enum Emotion { HAPPY, SAD }
enum Pattern { NONE, DOTS, FEATHERS }
enum MaskColor { RED, GREEN, BLUE }

# Linked to phenotype 
enum Mouth { SNOUT, BEAK }
enum Shape { PEAR, FRILL, CARNIVORE, DUCKBILL, EGG }

@export var species: Species
@export var emotion: Emotion
@export var pattern: Pattern
@export var color: MaskColor

const PATTERN_TEXTURES: Dictionary[Pattern, CompressedTexture2D] = {
	Pattern.NONE : preload("uid://d3v8eynat77lb"),
	Pattern.DOTS : preload("uid://d3v8eynat77lb"),
	Pattern.FEATHERS : preload("uid://d3v8eynat77lb"),
};
const COLORS: Dictionary[MaskColor, Color] = {
	MaskColor.RED : Color.RED,
	MaskColor.GREEN : Color.GREEN,
	MaskColor.BLUE : Color.BLUE,
}
const PHENOTYPES: Dictionary[Species, Phenotype] = {
	Species.DIPLODOCUS : preload("uid://celuv2kf4o7sn"),
	Species.BRACHIOSAURUS : preload("uid://cg5gixg40bs3s"),
	Species.TRICERATOPS : preload("uid://cwo2a675fq8gp"),
	Species.PROTOCERATOPS : preload("uid://dxw2347a4qjtx"),
	Species.TYRANNOSAURUS : preload("uid://ceath71l54m1v"),
	Species.CERATOSAURUS : preload("uid://bm7npt70grt6n"),
	Species.HADROSAURUS : preload("uid://cvi1h2orrjnp6"),
	Species.PARASAUROLOPHUS : preload("uid://bbrqruxw38oaq"),
	Species.OVIRAPTOR : preload("uid://bypngs0p73xle"),
}

func _init() -> void:
	species = Species.DIPLODOCUS
	emotion = Emotion.HAPPY
	pattern = Pattern.NONE
	color = MaskColor.RED

func get_phenotype() -> Phenotype:
	return PHENOTYPES[species]

func get_emotion_texture() -> CompressedTexture2D:
	return get_phenotype().EMOTIONS_TEXTURES[emotion]

func get_color() -> Color:
	return COLORS[color]
