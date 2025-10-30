extends AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("p2low"):
		print("p2 input low kick")
	elif Input.is_action_just_pressed("p2back"):
		print("p2 input back kick")
	elif Input.is_action_just_pressed("p2high"):
		print("p2 input high kick")
