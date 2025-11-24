extends Node2D


@export var RoundTimer : Timer

var gameStage: Globals.GameStage
var p1Kick: Globals.KickType 
var p2Kick: Globals.KickType 
var p1Hp: int
var p2Hp: int
var p1Time: float
var p2Time: float


func _ready() -> void:
	p1Hp = 10
	p2Hp = 10
	
	EventBus.player_kick.connect(_on_player_kicked)
	RoundTimer.timeout.connect(_begin_postgame) if RoundTimer else print("Timer not connected")
	_begin_pregame()
	
	
func _begin_pregame():
	gameStage = Globals.GameStage.Pregame
	EventBus.on_stage_changed.emit(gameStage)
	p1Kick = Globals.KickType.Empty
	p2Kick = Globals.KickType.Empty
	p1Time = 0
	p2Time = 0
	print("P1 HP: " , p1Hp)
	print("P2 HP: " , p2Hp)
	print("Ready...")
	await get_tree().create_timer(3.0).timeout
	_begin_selection()

func _begin_selection():
	gameStage = Globals.GameStage.Selection
	EventBus.on_stage_changed.emit(gameStage)
	print("Selection Started!")
	RoundTimer.start()
	
func _begin_postgame():
	gameStage = Globals.GameStage.Postgame
	EventBus.on_stage_changed.emit(gameStage)

	var winner = _resolve_combat()
	_print_combat_result(winner)

	if winner == Globals.Player.Player1:
		$player1._kick(p1Kick)
		$player2._takeDamage()
	else:
		$player2._kick(p2Kick)
		$player1._takeDamage()

	_deal_damage(winner)
	EventBus.log_kick.emit(Globals.Player.Player1, p1Kick)
	EventBus.log_kick.emit(Globals.Player.Player2, p2Kick)
	EventBus.declare_winner.emit(winner)

	if p2Hp <= 0:
		_begin_endgame(Globals.Player.Player1)
	elif p1Hp <= 0:
		_begin_endgame(Globals.Player.Player2)
	else:
		await get_tree().create_timer(5.0).timeout
		_begin_pregame()

func _resolve_combat() -> Globals.Player:
	# Handle empty kicks first
	if p1Kick == Globals.KickType.Empty and p2Kick == Globals.KickType.Empty:
		return Globals.Player.Player1 if p1Time >= p2Time else Globals.Player.Player2
	if p1Kick == Globals.KickType.Empty:
		return Globals.Player.Player2
	if p2Kick == Globals.KickType.Empty:
		return Globals.Player.Player1

	# Check if P1 wins
	if _does_kick_beat(p1Kick, p2Kick):
		return Globals.Player.Player1
	# Check if P2 wins
	elif _does_kick_beat(p2Kick, p1Kick):
		return Globals.Player.Player2
	# Tie - winner based on timing
	else:
		return Globals.Player.Player1 if p1Time >= p2Time else Globals.Player.Player2

func _does_kick_beat(attacker: Globals.KickType, defender: Globals.KickType) -> bool:
	return (attacker == Globals.KickType.High and defender == Globals.KickType.Low) or \
		   (attacker == Globals.KickType.Back and defender == Globals.KickType.High) or \
		   (attacker == Globals.KickType.Low and defender == Globals.KickType.Back)

func _print_combat_result(winner: Globals.Player):
	if p1Kick == Globals.KickType.Empty and p2Kick == Globals.KickType.Empty:
		print("It's a tie!")
	elif p1Kick == Globals.KickType.Empty:
		print("P2 wins!")
	elif p2Kick == Globals.KickType.Empty:
		print("P1 wins!")
	elif winner == Globals.Player.Player1:
		var damage = p1Kick
		print("P1 wins! P2 loses ", damage, " hp")
	else:
		var damage = p2Kick
		print("P2 wins! P1 loses ", damage, " hp")

func _begin_endgame(winner: Globals.Player):
	gameStage = Globals.GameStage.Endgame
	EventBus.on_stage_changed.emit(gameStage)
	match winner:
		Globals.Player.Player1:
			print("P1 beats P2!")
		Globals.Player.Player2:
			print("P2 beats P1!")
	
func _deal_damage(winner: Globals.Player):
	match winner:
		Globals.Player.Player1:
			p2Hp -= p1Kick
		Globals.Player.Player2:
			p1Hp -= p2Kick
	EventBus.update_hp.emit(p1Hp, p2Hp)
	
	
func _on_player_kicked(player: Globals.Player, kick: Globals.KickType):
	if ((player == 1 and p1Kick != Globals.KickType.Empty) or (player == 2 and p2Kick != Globals.KickType.Empty)): return
	if (gameStage != Globals.GameStage.Selection): return
	
	match player:
		Globals.Player.Player1:
			print("Kick Saved for player 1: " , kick)
			p1Kick = kick
			p1Time = RoundTimer.time_left
		Globals.Player.Player2:
			print("Kick Saved for player 2: " , kick)
			p2Kick = kick
			p2Time = RoundTimer.time_left
	
