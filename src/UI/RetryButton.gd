extends Button


func _on_button_up() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if Input.is_action_just_released("retry"):
		_on_button_up()
