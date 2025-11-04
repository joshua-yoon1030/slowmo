extends Control

var action_to_rebind = ""
var waiting = false
var inputNames = ["p1low", "p1back", "p1high", "p2low", "p2back", "p2high"]

func start_rebind(action_name: String):
	action_to_rebind = action_name
	waiting = true
	#display waiting for key hud
	print("Waiting, press a key to bind")

func _unhandled_input(event):
	if waiting and event is InputEventKey and event.pressed:
		InputMap.action_erase_events(action_to_rebind)
		InputMap.action_add_event(action_to_rebind, event)
		waiting = false
		save_bindings()
		#remove waiting for key hud

func save_bindings():
	var config := ConfigFile.new()
	for action in InputMap.get_actions():
		var events = InputMap.action_get_events(action)
		var event_data = []
		for e in events:
			if e is InputEventKey:
				event_data.append(e.physical_keycode)
		config.set_value("bindings", action, event_data)
	config.save("user://bindings.cfg")


func _on_p1low_button_pressed() -> void:
	start_rebind("p1low")
