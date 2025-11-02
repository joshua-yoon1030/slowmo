extends Node2D


@export var RoundTimer : Timer

var gameStage: Globals.GameStage
var p1Kick: Globals.KickType 
var p2Kick: Globals.KickType 


func _ready() -> void:
	EventBus.player_kick.connect(_on_player_kicked)
	RoundTimer.timeout.connect(_begin_postgame) if RoundTimer else print("Timer not connected")
	_begin_pregame()
	
	
func _begin_pregame():
	gameStage = Globals.GameStage.Pregame 
	p1Kick = Globals.KickType.Empty
	p2Kick = Globals.KickType.Empty
	print("Ready...")
	await get_tree().create_timer(3.0).timeout
	_begin_selection()

func _begin_selection():
	gameStage = Globals.GameStage.Selection
	print("Selection Started!")
	RoundTimer.start()
	
func _begin_postgame():
	gameStage = Globals.GameStage.Postgame
	
	match [p1Kick, p2Kick]:
		[Globals.KickType.Empty, Globals.KickType.Empty]:
			print("It's a tie!")
		[Globals.KickType.Empty, _]:
			print("P2 wins!")
		[_, Globals.KickType.Empty]:
			print("P1 wins!")
		[Globals.KickType.High, Globals.KickType.Low]:
			print("P1 wins! P2 loses 3 hp")
		[Globals.KickType.Back, Globals.KickType.High]:
			print("P1 wins! P2 loses 2 hp")
		[Globals.KickType.Low, Globals.KickType.Back]:
			print("P1 wins! P2 loses 1 hp")
		[Globals.KickType.Low, Globals.KickType.High]:
			print("P2 wins! P1 loses 3 hp")
		[Globals.KickType.High, Globals.KickType.Back]:
			print("P2 wins! P1 loses 2 hp")
		[Globals.KickType.Back, Globals.KickType.Low]:
			print("P2 wins! P1 loses 1 hp")
		_:
			print("I will implement ties later")
	#do health checks here, lead to endgame, else lead back to pregame
	_begin_pregame()
	
	
	
func _on_player_kicked(player: Globals.Player, kick: Globals.KickType):
	if ((player == 1 and p1Kick != Globals.KickType.Empty) or (player == 2 and p2Kick != Globals.KickType.Empty)): return
	if (gameStage != Globals.GameStage.Selection): return
	
	match player:
		Globals.Player.Player1:
			print("Kick Saved for player 1: " , kick)
			p1Kick = kick
		Globals.Player.Player2:
			print("Kick Saved for player 2: " , kick)
			p2Kick = kick
