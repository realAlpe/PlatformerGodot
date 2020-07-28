extends Node2D

onready var level_name = get_node("UserInterface/UserInterface/Panel/CenterContainer/VBoxContainer/LevelName")
onready var timer = get_node("UserInterface/UserInterface/Panel/CenterContainer/VBoxContainer/Label")
onready var portal = get_node("Objects/PortalScene/PortalHitboxArea2D")
var timer_valid = true

func _ready() -> void:
	portal.connect("entered", self, "_on_entered")
	timer.connect("timer_overdue", self, "_on_timer_overdue")
	if LevelData.access_to_level.count(name) == 0:
		LevelData.access_to_level.append(name)
	level_name.set_level_name(name)

func _on_timer_overdue():
	timer_valid = false

func _on_entered():
	if timer_valid:
		if LevelData.finished_level_under_time.count(name) == 0:
			LevelData.finished_level_under_time.append(name)

func _exit_tree() -> void:
	LevelData.previous_scene = "res://src/Levels/%s.tscn" % name
