extends Control

var fullscreen = false
var borderless = false
onready var menu_button = $MarginContainer/Main/MarginContainer/VBoxContainer/MenuButton
onready var anim_player = get_node("FadeInTransition/AnimationPlayer")

func _ready() -> void:
	menu_button.connect("pressed", self, "_on_MenuButton_pressed")
	
func _on_Fullscreen_pressed() -> void:
	fullscreen = not fullscreen
	OS.window_fullscreen = fullscreen

func _on_Borderless_pressed() -> void:
	borderless = not borderless
	OS.window_borderless = borderless

func _on_MenuButton_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene("res://TitleScreen_New/TitleScreen.tscn")
