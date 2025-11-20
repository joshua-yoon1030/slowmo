extends CanvasLayer

@export var P1HP: ProgressBar
@export var P2HP: ProgressBar
@export var P1KickHud: Panel
@export var P2KickHud: Panel
@export var P1KickList: VBoxContainer
@export var P2KickList: VBoxContainer
@export var InformationText: Label
@export var ZoomCamera: ZoomCamera

func _ready():
	P1HP.value = 10
	P2HP.value = 10
	EventBus.update_hp.connect(OnHpUpdate)
	EventBus.log_kick.connect(OnLogKick)
	EventBus.on_stage_changed.connect(OnStageChange)
	EventBus.declare_winner.connect(ChangeWinnerText)

func OnHpUpdate(p1hp: int, p2hp: int):
	P1HP.value = p1hp
	P2HP.value = p2hp

func OnLogKick(player: Globals.Player, kick: Globals.KickType):
	var list = P1KickList if player == 1 else P2KickList
	var label = Label.new()
	match kick:
		Globals.KickType.Empty:
			label.text = "Empty"
		Globals.KickType.Low:
			label.text = "Low Kick"
		Globals.KickType.Back:
			label.text = "Back Kick"
		Globals.KickType.High:
			label.text = "High Kick"
	label.add_theme_font_size_override("font_size", 30)
	list.add_child(label)
	
func OnStageChange(stage: Globals.GameStage):
	match stage:
		Globals.GameStage.Pregame:
			InformationText.text = "Ready..."
		Globals.GameStage.Selection:
			ZoomCamera.zoom_to_set_point(Vector2(2.0, 2.0), 5.0)
			InformationText.text = "Pick your Move!"
			toggleHud(false)
		Globals.GameStage.Postgame:
			ZoomCamera.zoom_out(1.0)
			toggleHud(true)
func ChangeWinnerText(player: Globals.Player):
	match player:
		Globals.Player.Player1:
			InformationText.text = "Player 1 Wins!"
		_:
			InformationText.text = "Player 2 Wins!"

func toggleHud(visible : bool):
	P1KickHud.visible = visible
	P2KickHud.visible = visible
