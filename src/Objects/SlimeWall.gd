extends Area2D

func _on_SlimeWall_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.on_slime_wall = true

func _on_SlimeWall_body_exited(body: Node) -> void:
	if body.name == "Player":
		body.on_slime_wall = false
