extends Area2D


onready var anim_player: = get_node("AnimationPlayer")
var count = 0

func _on_Area2D_body_entered(body: Node) -> void:
	if count == 0:
		count = 1
		anim_player.play("Porter_change_pos")
		yield(anim_player, "animation_finished")
		body.position = $TeleportPos.position
