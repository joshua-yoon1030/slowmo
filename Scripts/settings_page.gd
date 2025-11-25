extends Control

@export var p1low: Button
@export var p1back: Button
@export var p1high: Button
@export var p2low: Button
@export var p2back: Button
@export var p2high: Button

var action_to_rebind = ""
var waiting = false
var inputNames = ["p1low", "p1back", "p1high", "p2low", "p2back", "p2high"]
var buttons = []
var pickKeyHudFile = preload("res://HUDS/waiting_for_key_hud.tscn")
var pickKeyHud : CanvasLayer
var hudText : Label
var msg1 = "Press any Key to rebind..."
var msg2 = "This key is already bound to something else, press any key to rebind..."



func _ready():
	buttons = [p1low, p1back, p1high, p2low, p2back, p2high] #exported values are loaded later so I need to do it on scene enter
	pickKeyHud = pickKeyHudFile.instantiate()
	add_child(pickKeyHud)
	hudText = pickKeyHud.get_node("MsgText")
	pickKeyHud.visible = false
	

func start_rebind(action_name: String):
	action_to_rebind = action_name
	waiting = true
	pickKeyHud.visible = true
	print("Waiting, press a key to bind")

func _unhandled_input(event):
	if waiting and event is InputEventKey and event.pressed:
		if is_used_key(action_to_rebind, event):
			hudText.text = msg2
			return
		InputMap.action_erase_events(action_to_rebind)
		InputMap.action_add_event(action_to_rebind, event)
		waiting = false
		save_bindings()
		hudText.text = msg1
		pickKeyHud.visible = false

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

func is_used_key(action_to_rebind: String, event: InputEvent) -> bool:
	for i in range(len(inputNames)):
		if inputNames[i] == action_to_rebind: continue
		var conflict = InputMap.action_get_events(inputNames[i])
		if conflict[0].physical_keycode == event.physical_keycode:
			return true
	return false
	
func _process(delta: float):
	for i in range(len(inputNames)):
		var event = InputMap.action_get_events(inputNames[i])
		if event[0] is InputEventKey:
			var key_name = OS.get_keycode_string(event[0].physical_keycode)
			buttons[i].text = key_name

func _on_p1low_button_pressed() -> void:
	start_rebind("p1low")


func _on_p1back_button_pressed() -> void:
	start_rebind("p1back")


func _on_p1high_button_pressed() -> void:
	start_rebind("p1high")


func _on_p2low_button_pressed() -> void:
	start_rebind("p2low")


func _on_p2back_button_pressed() -> void:
	start_rebind("p2back")


func _on_p2high_button_pressed() -> void:
	start_rebind("p2high")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
