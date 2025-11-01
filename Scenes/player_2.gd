extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("p2low"):
		EventBus.player_kick.emit(2, Globals.KickType.Low)
		print("p2 input low kick")
	elif Input.is_action_just_pressed("p2back"):
		EventBus.player_kick.emit(2, Globals.KickType.Back)
		print("p2 input back kick")
	elif Input.is_action_just_pressed("p2high"):
		EventBus.player_kick.emit(2, Globals.KickType.High)
		print("p2 input high kick")
