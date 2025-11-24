extends AnimatedSprite2D


func _process(delta):
	if Input.is_action_just_pressed("p1low"):
		EventBus.player_kick.emit(1, Globals.KickType.Low)
	elif Input.is_action_just_pressed("p1back"):
		EventBus.player_kick.emit(1, Globals.KickType.Back)
	elif Input.is_action_just_pressed("p1high"):
		EventBus.player_kick.emit(1, Globals.KickType.High)

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
func _takeDamage():
	play("die")
	await animation_finished
	play("idle")
