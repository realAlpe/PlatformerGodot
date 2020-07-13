extends Node

signal player_died

var deaths: = 0 setget set_deaths

export var completed_Level01 = false

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
