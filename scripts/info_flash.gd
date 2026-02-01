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
	SignalBus.play_sfx.emit(SignalBus.SFX.HINT)
	await tween1.finished
	timer_label.show()
	timer.wait_time = duration
	timer.start()
	await timer.timeout
	timer_label.hide()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, 'position', offset, tween_duration)
	tween2.tween_callback(hide)
	SignalBus.play_sfx.emit(SignalBus.SFX.HINT)
	await tween2.finished

func _gui_input(event: InputEvent) -> void:
	if visible and (event is InputEventMouseButton or event is InputEventKey):
		timer.stop()
		timer.timeout.emit()

func _process(_delta: float) -> void:
	timer_label.text = str(snapped(timer.time_left, 0.1)) + "s"

func set_description(description: Description):
	var text: String = ""
	var line_break = str("
")
	match description.species:
		Description.Species.DIPLODOCUS:
			text += str("[ul]My dino mask is a [font_size=54]Diplodocus[/font_size]")
			text += str(line_break, "His head is pear-shaped")
		Description.Species.BRACHIOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Brachiosaurus[/font_size]")
			text += str(line_break, "His head is pear-shaped")
			text += str(line_break, "He has a crest")
		Description.Species.TRICERATOPS:
			text += str("[ul]My dino mask is a [font_size=54]Triceratops[/font_size]")
			text += str(line_break, "He has a frill")
			text += str(line_break, "He has a beak")
		Description.Species.PROTOCERATOPS:
			text += str("[ul]My dino mask is a [font_size=54]Protoceratops[/font_size]")
			text += str(line_break, "He has a frill")
			text += str(line_break, "He has a beak")
		Description.Species.TYRANNOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Tyrannosaurus[/font_size]")
			text += str(line_break, "He has a teethed mouth")
		Description.Species.CERATOSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Ceratosaurus[/font_size]")
			text += str(line_break, "He has a teethed mouth")
			text += str(line_break, "He has a horn")
		Description.Species.HADROSAURUS:
			text += str("[ul]My dino mask is a [font_size=54]Hadrosaurus[/font_size]")
			text += str(line_break, "He has a duck bill")
		Description.Species.PARASAUROLOPHUS:
			text += str("[ul]My dino mask is a [font_size=54]Parasaurolophus[/font_size]")
			text += str(line_break, "He has a crest")
			text += str(line_break, "He has a duck bill")
		Description.Species.OVIRAPTOR:
			text += str("[ul]My dino mask is a [font_size=54]Oviraptor[/font_size]")
			text += str(line_break, "He has a crest")
			text += str(line_break, "He has a beak")
		_:
			pass
	match description.color:
		Description.MaskColor.RED:
			text += str(line_break, "He is red")
		Description.MaskColor.GREEN:
			text += str(line_break, "He is green")
		Description.MaskColor.BLUE:
			text += str(line_break, "He is blue")
		_:
			pass
	match description.pattern:
		Description.Pattern.DOTS:
			text += str(line_break, "He is covered in dots")
		Description.Pattern.FEATHERS:
			text += str(line_break, "He is covered in feathers")
		_:
			pass
	match description.emotion:
		Description.Emotion.HAPPY:
			text += str(line_break, "He looks happy[/ul]")
		Description.Emotion.SAD:
			text += str(line_break, "He looks sad[/ul]")
		_:
			pass
	update_text(text)

func update_text(text: String):
	info_flash_richtext.clear()
	info_flash_richtext.append_text(text)
