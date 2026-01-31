extends Control

@onready var info_flash_richtext: RichTextLabel = %info_flash_richtext

func set_description(description: Description):
	var text: String
	text += str("[ul]")
	match description.color:
		Description.MaskColor.RED:
			text += str("This dino is red")
		Description.MaskColor.GREEN:
			text += str("This dino is green")
		Description.MaskColor.BLUE:
			text += str("This dino is blue")
		_:
			pass
	text += str("[/ul]")
	update_text(text)

func update_text(text: String):
	info_flash_richtext.clear()
	info_flash_richtext.append_text(text)
