extends Node

func _ready():
	load_bindings()

func load_bindings():
	var config := ConfigFile.new()
	if config.load("user://bindings.cfg") != OK:
		return  # No saved bindings yet — stick with defaults

	# Reset to defaults first (so missing bindings aren’t lost)
	InputMap.load_from_project_settings()

	for action in config.get_section_keys("bindings"):
		InputMap.action_erase_events(action)
		for key in config.get_value("bindings", action, []):
			var ev := InputEventKey.new()
			ev.physical_keycode = key
			InputMap.action_add_event(action, ev)
