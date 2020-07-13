extends Label

signal timer_overdue

onready var UI = get_node("../../../..")

var seconds = 0
var minutes = 0
var name_of_level

func _ready() -> void:
	set_text(str("00", " : ", "00"))

func _on_Timer_timeout() -> void:
	seconds += 1
	if seconds == 60:
		seconds = 0
		minutes += 1
	if seconds == UI.level_length_sec and minutes == UI.level_length_min:
		emit_signal("timer_overdue")
		modulate = Color(1, 0.31, 0.47, 1)
	
	set_text(str(str(minutes).pad_zeros(2), " : ", str(seconds).pad_zeros(2)))
