extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("p2low"):
		EventBus.player_kick.emit(2, Globals.KickType.Low)
	elif Input.is_action_just_pressed("p2back"):
		EventBus.player_kick.emit(2, Globals.KickType.Back)
	elif Input.is_action_just_pressed("p2high"):
		EventBus.player_kick.emit(2, Globals.KickType.High)

func _kick(kick: Globals.KickType):
	match kick:
		Globals.KickType.Low:
			play("low")
		Globals.KickType.Back:
			play("back")
		Globals.KickType.High:
			play("high")
	await animation_finished
	play("idle")
