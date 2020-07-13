extends Button

export(String) var level_name
export(String, FILE) var scene_to_load

onready var anim_player = get_tree().root.get_node("Levels/FadeInTransition/AnimationPlayer")

func _ready() -> void:
	if level_name in LevelData.access_to_level:
		disabled = false

func _on_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene(scene_to_load)
