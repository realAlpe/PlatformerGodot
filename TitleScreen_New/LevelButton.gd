extends Button

export(String, FILE) var scene_to_load

onready var anim_player = get_tree().root.get_node_or_null("Levels/FadeInTransition/AnimationPlayer")
onready var star_texture = $TextureRect

func _ready() -> void:
	var level_name = "Level" + text
	
	if level_name in LevelData.access_to_level:
		disabled = false
	if level_name in LevelData.finished_level_under_time:
		star_texture.visible = true

func _on_pressed() -> void:
	anim_player.play("fade_out_transition")
	yield(anim_player,"animation_finished")
	get_tree().change_scene(scene_to_load)

