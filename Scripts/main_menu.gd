extends Control

var menu_options := [
	{"label": "Start Game", "scene": "res://HUDS/HowToPlayHud.tscn"},
	{"label": "Settings", "scene": "res://Scenes/settings_page.tscn"},
]

var current_selection := 0

@onready var menu_container: VBoxContainer = $CenterContainer/VBoxContainer

func _ready() -> void:
	_build_menu()
	_update_selection()

func _build_menu() -> void:
	for i in menu_options.size():
		var label := Label.new()
		label.text = menu_options[i]["label"]
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 50)
		menu_container.add_child(label)

func _update_selection() -> void:
	for i in menu_container.get_child_count():
		var label: Label = menu_container.get_child(i)
		if i == current_selection:
			label.text = "> " + menu_options[i]["label"] + " <"
			label.modulate = Color.YELLOW
		else:
			label.text = menu_options[i]["label"]
			label.modulate = Color.WHITE

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.physical_keycode:
			KEY_DOWN, KEY_S:
				current_selection = (current_selection + 1) % menu_options.size()
				_update_selection()
			KEY_UP, KEY_W:
				current_selection = (current_selection - 1 + menu_options.size()) % menu_options.size()
				_update_selection()
			KEY_ENTER, KEY_SPACE:
				_select_option()

func _select_option() -> void:
	var scene_path: String = menu_options[current_selection]["scene"]
	get_tree().change_scene_to_file(scene_path)
