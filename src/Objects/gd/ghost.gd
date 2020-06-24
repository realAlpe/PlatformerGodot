extends Sprite

func _ready() -> void:
	$alpha_tween.interpolate_property(self, "modulate", Color(1, 0.31, 0.47, .5), Color(1, 0.31, 0.47, 0), 0.55, Tween.TRANS_SINE, Tween.EASE_OUT)
	$alpha_tween.start()

func _on_alpha_tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()
