extends Area2D

onready var sprite: = $Sprite
onready var sprite_timer: = $SpriteTimer
var currently_triggered: = false

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body) -> void:
	if not currently_triggered:
		body.velocity.y = 0
		body.velocity.y -= 950
		body.dash_count = 0
		sprite.frame = 1
		sprite_timer.start()
		currently_triggered = true

func _on_SpriteTimer_timeout() -> void:
	sprite.frame = 0
	currently_triggered = false



