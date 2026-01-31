extends HBoxContainer

@onready var mask: Mask = $Panel/Mask

func on_level_loaded(level: int) -> void:
	$Label.text = "Current level: %d" % level
	mask.set_description(DescriptionMaker.target_description)
