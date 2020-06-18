extends Node

signal player_died

var deaths: = 0 setget set_deaths


func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
