extends Area2D

func _on_Conveyor5_body_entered(body: Node) -> void:
	body.is_inside_conveyor_area = true


func _on_Conveyor5_body_exited(body: Node) -> void:
	body.is_inside_conveyor_area = false
