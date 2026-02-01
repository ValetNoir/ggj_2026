class_name InfoFlash
extends Control

@onready var info_flash_richtext: RichTextLabel = %info_flash_richtext
@onready var timer_label: RichTextLabel = $TimerLabel
@onready var timer: Timer = $Timer
@export var tween_duration: float = 1.0

# Call this method to display the info flash for 'duration'
func on_new_level_diplay_info_flash(duration: float):
	await get_tree().create_timer(0.3).timeout
	set_description(DescriptionMaker.target_description)
	await display_info(duration)

func display_info(duration: float):
	var offset = Vector2(0, get_viewport_rect().size.y)
	position = offset
	show()
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, 'position', Vector2.ZERO, tween_duration)
	await tween1.finished
	timer_label.show()
	timer.wait_time = duration
	timer.start()
	await timer.timeout
	timer_label.hide()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, 'position', offset, tween_duration)
	tween2.tween_callback(hide)
	await tween2.finished

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		pass

func _process(_delta: float) -> void:
	timer_label.text = str(snapped(timer.time_left, 0.1)) + "s"

func set_description(description: Description):
	var text: String = ""
	#text += str("[ul]")
	match description.species:
		Description.Species.DIPLODOCUS:
			text += str("[ul]My dino mask is a [font_size=54]Diplodocus[/font_size][br]")
			text += str("His head is pear-shaped[br]")
		Description.Species.BRACHIOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Brachiosaurus[/font_size][br]")
			text += str("His head is pear-shaped[br]")
			text += str("He has a crest[br]")
		Description.Species.TRICERATOPS:
			text += str("[ul]My dino mask is a [font_size=54]Triceratops[/font_size][br]")
			text += str("He has a frill[br]")
			text += str("He has a beak[br]")
		Description.Species.PROTOCERATOPS:
			text += str("[ul]My dino mask is a [font_size=54]Protoceratops[/font_size][br]")
			text += str("He has a frill[br]")
			text += str("He has a beak[br]")
		Description.Species.TYRANNOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Tyrannosaurus[/font_size][br]")
			text += str("He has a teethed mouth[br]")
		Description.Species.CERATOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Ceratosaurus[/font_size][br]")
			text += str("He has a teethed mouth[br]")
			text += str("He has a horn[br]")
		Description.Species.HADROSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Hadrosaurus[/font_size][br]")
			text += str("He has a duck bill[br]")
		Description.Species.PARASAUROLOPHUS:
			text += str("[ul]My dino mask is a [font_size=54]Parasaurolophus[/font_size][br]")
			text += str("He has a crest[br]")
			text += str("He has a duck bill[br]")
		Description.Species.OVIRAPTOR:
			text += str("[ul]My dino mask is a [font_size=54]Oviraptor[/font_size][br]")
			text += str("He has a crest[br]")
			text += str("He has a beak[br]")
		_:
			pass
	match description.color:
		Description.MaskColor.RED:
			text += str("He is red[br]")
		Description.MaskColor.GREEN:
			text += str("He is green[br]")
		Description.MaskColor.BLUE:
			text += str("He is blue[br]")
		_:
			pass
	match description.pattern:
		Description.Pattern.DOTS:
			text += str("He is covered in dots[br]")
		Description.Pattern.FEATHERS:
			text += str("He is covered in feathers[br]")
		_:
			pass
	match description.emotion:
		Description.Emotion.HAPPY:
			text += str("He looks happy[br][/ul]")
		Description.Emotion.SAD:
			text += str("He looks sad[br][/ul]")
		_:
			pass
	update_text(text)

func update_text(text: String):
	info_flash_richtext.clear()
	info_flash_richtext.append_text(text)
