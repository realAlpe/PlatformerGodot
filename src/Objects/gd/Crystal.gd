extends Area2D

onready var timer = $Timer
onready var anim_player = $AnimationPlayer
onready var sprite_empty = $SpriteEmpty
var not_used: = true

func _ready() -> void:
	sprite_empty.visible = false
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if not_used and body.dash_count != 0:
		sprite_empty.visible = true
		timer.start()
		not_used = false
		body.dash_count = 0
		$CrystalCollectedParticle.emitting = true
		anim_player.play("fade_out_crystal")

func _on_Timer_timeout() -> void:
	sprite_empty.visible = false
	not_used = true
	anim_player.play("START_crystal")
