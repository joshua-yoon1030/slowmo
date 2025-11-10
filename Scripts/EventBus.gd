extends Node
signal player_kick(player: Globals.Player, kick: Globals.KickType)
signal log_kick(player: Globals.Player, kick: Globals.KickType)
signal update_hp(p1hp: int, p2hp: int)
signal on_stage_changed(state: Globals.GameStage)
