extends Control

onready var anim_player = $FadeInTransition/AnimationPlayer
	
func _on_NewGameButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://src/Levels/Level01.tscn")

func _on_ContinueButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://TitleScreen_New/Levels.tscn")

func _on_OptionsButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://TitleScreen_New/Options.tscn")

func _on_Controls_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://TitleScreen_New/Controls.tscn")

func _on_Exit_Game_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().quit()

func _exit_tree() -> void:
	LevelData.previous_scene = "res://TitleScreen_New/TitleScreen.tscn"
