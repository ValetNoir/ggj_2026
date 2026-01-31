class_name Description
extends Resource

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
enum Mouth { SNOUT, BEAK }
enum Shape { PEAR, FRILL, CARNIVORE, DUCKBILL, EGG }
enum Emotion { HAPPY, SAD }
enum Pattern { NONE, DOTS, FEATHERS }
enum MaskColor { RED, GREEN, BLUE }

@export var phenotype: Phenotype
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

func _init():
	phenotype = null
	emotion = Emotion.HAPPY
	pattern = Pattern.NONE
	color = MaskColor.RED
