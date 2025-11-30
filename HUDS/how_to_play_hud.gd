extends CanvasLayer

@export var Player1Controls : Array[Label]
@export var Player2Controls : Array[Label]

var inputNamesp1 = ["p1low", "p1back", "p1high"]
var inputNamesp2 = ["p2low", "p2back", "p2high"]

func _ready() -> void:
	
	for i in range(len(inputNamesp1)):
		var eventp1 = InputMap.action_get_events(inputNamesp1[i])[0]
		var eventp2 = InputMap.action_get_events(inputNamesp2[i])[0]
		Player1Controls[i].text = OS.get_keycode_string(eventp1.physical_keycode)
		Player2Controls[i].text = OS.get_keycode_string(eventp2.physical_keycode)
		


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainGame2P.tscn")
