extends StaticBody2D

onready var anim_player: = $AnimationPlayer

func _ready() -> void:
	$area.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body.name == "Player" and body.get("keys") > 0:
		body.keys -= 1
		anim_player.play("KEYDOOR_open_anim")
		yield(anim_player, "animation_finished")
		queue_free()
