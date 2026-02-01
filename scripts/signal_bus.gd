extends Node

enum MUSIC {
	TITLE,
	GAME
}

enum SFX {
	FOUND_TARGET,
	WRONG_TARGET,
	STRIKE_CORRECT,
	STRIKE_WRONG,
	OPEN_CURTAIN,
	CLOSE_CURTAIN,
	CROWD,
	HINT
}

@warning_ignore("unused_signal") signal play_music(soundtrack: MUSIC)
@warning_ignore("unused_signal") signal play_sfx(soundtrack: SFX)
