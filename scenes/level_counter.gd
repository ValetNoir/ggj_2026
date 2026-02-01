extends RichTextLabel


func update_level_text(level_index: int, levels_count: int) -> void:
	text = str("Level ", level_index + 1 , " / ", levels_count)
