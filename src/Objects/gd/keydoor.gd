extends StaticBody2D

onready var anim_player: = $AnimationPlayer
onready var key_anim = $Position2D/key/AnimationPlayer
var count = 0

func _on_key_body_entered(body: Node) -> void:
	if body.name == "Player" and count == 0:
		count = 1
		key_anim.play("KEY_fade_red")
		anim_player.play("KEYDOOR_open_anim")
		yield(anim_player, "animation_finished")
		$CollisionShape2D.disabled = true
