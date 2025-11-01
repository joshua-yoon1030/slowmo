extends Node2D

var p1Kick: Globals.KickType 
var p2Kick: Globals.KickType 


func _ready() -> void:
	p1Kick = Globals.KickType.Empty
	p2Kick = Globals.KickType.Empty
	EventBus.player_kick.connect(_on_player_kicked)
	

func _on_player_kicked(player: Globals.Player, kick: Globals.KickType):
	if ((player == 1 and p1Kick != Globals.KickType.Empty) or (player == 2 and p2Kick != Globals.KickType.Empty)): return
	
	match player:
		Globals.Player1:
			p1Kick = kick
		Globals.Player2:
			p2Kick = kick
	
