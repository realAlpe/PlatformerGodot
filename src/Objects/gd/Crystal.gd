extends Area2D

onready var timer: = $Timer
onready var anim_player: = $AnimationPlayer
var not_used: = true

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if not_used and body.dash_count != 0:
		timer.start()
		not_used = false
		body.dash_count = 0
		anim_player.play("fade_out_crystal")

func _on_Timer_timeout() -> void:
	anim_player.play("START_crystal")
	not_used = true
