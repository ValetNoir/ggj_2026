class_name InfoFlash
extends Control

@onready var info_flash_richtext: RichTextLabel = %info_flash_richtext

# Call this method to display the info flash for 'duration'
func on_new_level_diplay_info_flash(duration: float):
	await get_tree().create_timer(0.2).timeout
	set_description(DescriptionMaker.target_description)
	modulate = Color.WHITE
	show()
	await get_tree().create_timer(duration).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'modulate', Color.TRANSPARENT, 1.0)
	tween.tween_callback(hide)

func set_description(description: Description):
	var text: String
	#text += str("[ul]")
	match description.species:
		Description.Species.DIPLODOCUS:
			text += str("[ul]My dino is a [font_size=32]Diplodocus[/font_size][br]")
			text += str("Its head is pear-shaped[br]")
		Description.Species.BRACHIOSAURUS:
			text += str("[ul]My dino is a [font_size=32]Brachiosaurus[/font_size][br]")
			text += str("Its head is pear-shaped[br]")
			text += str("It's got a crest[br]")
		Description.Species.TRICERATOPS:
			text += str("[ul]My dino is a [font_size=32]Triceratops[/font_size][br]")
			text += str("It's got a frill[br]")
			text += str("It's got a beak[br]")
		Description.Species.PROTOCERATOPS:
			text += str("[ul]My dino is a [font_size=32]Protoceratops[/font_size][br]")
			text += str("It's got a frill[br]")
			text += str("It's got a beak[br]")
		Description.Species.TYRANNOSAURUS:
			text += str("[ul]My dino is a [font_size=32]Tyrannosaurus[/font_size][br]")
			text += str("It's a meat-eater[br]")
		Description.Species.CERATOSAURUS:
			text += str("[ul]My dino is a [font_size=32]Ceratosaurus[/font_size][br]")
			text += str("It's a meat-eater[br]")
			text += str("It's got a horn[br]")
		Description.Species.HADROSAURUS:
			text += str("[ul]My dino is a [font_size=32]Hadrosaurus[/font_size][br]")
			text += str("It's got a duck bill[br]")
		Description.Species.PARASAUROLOPHUS:
			text += str("[ul]My dino is a [font_size=32]Parasaurolophus[/font_size][br]")
			text += str("It's got a crest[br]")
			text += str("It's got a duck bill[br]")
		Description.Species.OVIRAPTOR:
			text += str("[ul]My dino is a [font_size=32]Oviraptor[/font_size][br]")
			text += str("It's got a crest[br]")
			text += str("It's got a beak[br]")
		_:
			pass
	match description.color:
		Description.MaskColor.RED:
			text += str("It is red[br]")
		Description.MaskColor.GREEN:
			text += str("It is green[br]")
		Description.MaskColor.BLUE:
			text += str("It is blue[br]")
		_:
			pass
	match description.pattern:
		Description.Pattern.DOTS:
			text += str("It is covered in dots[br]")
		Description.Pattern.FEATHERS:
			text += str("It is covered in feathers[br]")
		_:
			pass
	match description.emotion:
		Description.Emotion.HAPPY:
			text += str("It looks happy[br][/ul]")
		Description.Emotion.SAD:
			text += str("It looks sad[br][/ul]")
		_:
			pass
	update_text(text)

func update_text(text: String):
	info_flash_richtext.clear()
	info_flash_richtext.append_text(text)
