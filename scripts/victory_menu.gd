extends Control

@onready var game_timer: Timer = %GameTimer
@onready var rich_text_label: RichTextLabel = $Lore/LoreTextureRect/MarginContainer/RichTextLabel

func display(mistake_count: int):
	var offset = Vector2(0, get_viewport_rect().size.y)
	position = offset
	show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'position', Vector2.ZERO, 5)
	SignalBus.play_sfx.emit(SignalBus.SFX.HINT)
	
	var time_spent = snapped(1000000 - game_timer.time_left, 0.1)
	
	if mistake_count == 0:
		rich_text_label.text = str("You finally found me ![br][br]First try and in only ", time_spent, " seconds...[br]My beloved !!![br][br]Thank you for playing !!![br][br]Made by[br]Ghislain, Aeropulu, Railnof and valet_noir")
	else:
		rich_text_label.text = str("You finally found me ![br][br]And it only took you ", mistake_count,  " tries and ", time_spent, " seconds...[br][br]Thank you for playing !!![br][br]Made by[br]Ghislain, Aeropulu, Railnof and valet_noir")
