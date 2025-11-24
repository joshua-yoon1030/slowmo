extends CanvasLayer


func _ready() -> void:
	EventBus.on_stage_changed.connect(OnStageChange)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainGame2P.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func toggleHud(vis : bool):
	visible = vis

func OnStageChange (stage : Globals.GameStage):
	toggleHud(stage == Globals.GameStage.Endgame)
