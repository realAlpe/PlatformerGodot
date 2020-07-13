extends Button

onready var anim_player = $"../../../FadeInTransition/AnimationPlayer"

func _on_button_up() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if Input.is_action_just_released("retry"):
		_on_button_up()
