extends Control


func _on_start_pressed() -> void:
	$Panel.visible = true
	await get_tree().create_timer(3.0).timeout  # wait 3 seconds
	$Panel.visible = false
