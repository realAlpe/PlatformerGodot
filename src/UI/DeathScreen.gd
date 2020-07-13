extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $Background_screens
onready var anim_player: AnimationPlayer = $FadeInTransition/AnimationPlayer

func _on_RetryButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("retry"):
		_on_RetryButton_pressed()

func _on_MainScreenButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().change_scene("res://TitleScreen_New/TitleScreen.tscn")

func _on_ExitGameButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().quit()
