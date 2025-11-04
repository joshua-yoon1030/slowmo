extends AnimatedSprite2D


func _process(delta):
	if Input.is_action_just_pressed("p1low"):
		EventBus.player_kick.emit(1, Globals.KickType.Low)
	elif Input.is_action_just_pressed("p1back"):
		EventBus.player_kick.emit(1, Globals.KickType.Back)
	elif Input.is_action_just_pressed("p1high"):
		EventBus.player_kick.emit(1, Globals.KickType.High)
