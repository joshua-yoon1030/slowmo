class_name ZoomCamera
extends Camera2D


@export var focus : Node2D
var defaultPoint : Vector2

func _ready() -> void:
	defaultPoint = self.global_position
	

func zoom_to_set_point(dist: Vector2, dur: float):
	var old_zoom = zoom
	var old_pos = global_position
	var tween = create_tween()
	tween.parallel().tween_property(self, "zoom", dist, dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(self, "global_position", focus.global_position, dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func zoom_out(dur: float):
	var old_zoom = zoom
	var old_pos = global_position
	var tween = create_tween()
	tween.parallel().tween_property(self, "zoom", Vector2(1.0, 1.0), dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(self, "global_position", defaultPoint, dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
