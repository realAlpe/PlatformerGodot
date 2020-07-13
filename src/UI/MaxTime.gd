extends Label

onready var UI = get_node("../../../..")

func _ready() -> void:
	set_text(str(str(UI.level_length_min).pad_zeros(2), " : ", str(UI.level_length_sec).pad_zeros(2), "!"))
