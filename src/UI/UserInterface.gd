extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var pause_label = $PauseOverlay/MarginContainer/VBoxContainer/Panel/Label
onready var anim_player: AnimationPlayer = $FadeInTransition/AnimationPlayer

export(int) var level_length_sec = 1
export(int) var level_length_min = 0

var paused: = false setget set_paused


func _ready() -> void:
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_label.text != "YOU DIED":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_label.text = "YOU DIED"

func set_paused(value: bool) -> void:
	paused = value
	if paused:
		scene_tree.paused = value
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	pause_overlay.visible = value
	anim_player.play("fade_in_transition")
	yield(anim_player,"animation_finished")
	if not paused:
		scene_tree.paused = value


func _on_RetryButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("retry"):
		_on_RetryButton_pressed()

func _on_MainScreenButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen_New/TitleScreen.tscn")

func _on_ExitGameButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().quit()

func _on_Options_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen_New/Options.tscn")

func _on_Controls_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen_New/Controls.tscn")
