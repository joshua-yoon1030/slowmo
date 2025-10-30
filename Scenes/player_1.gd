extends AnimatedSprite2D


func _process(delta):
	if Input.is_action_just_pressed("p1low"):
		print("p1 input low kick")
	elif Input.is_action_just_pressed("p1back"):
		print("p1 input back kick")
	elif Input.is_action_just_pressed("p1high"):
		print("p1 input high kick")
