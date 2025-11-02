extends Node

enum Player {
	Player1 = 1,
	Player2 = 2,
	Bot = 3,
}

enum KickType {
	Empty = 0,
	Low = 1,
	Back = 2,
	High = 3,
}

enum GameStage {
	Pregame,
	Selection,
	Postgame
}
