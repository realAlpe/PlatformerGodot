extends Control

onready var anim_player = $FadeInTransition/AnimationPlayer


func _on_MenuButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://TitleScreen_New/TitleScreen.tscn")
