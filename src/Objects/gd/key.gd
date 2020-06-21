extends Area2D

onready var anim_player: = $AnimationPlayer
var count = 0

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if count == 0:
		if body.name == "Player":
			anim_player.play("KEY_fade_red")
			body.keys += 1
			count = 1

