extends Area2D

onready var anim_player = $AnimationPlayer
onready var tree = get_tree()

var is_in_area = false

func _on_InteractiveSign_body_entered(body: Node) -> void:
	if body.name == "Player":
		is_in_area = true
		anim_player.play("label_fade_in")
		body.camera_zoom_in_dialog()
		set_process_unhandled_input(true)

func _on_InteractiveSign_body_exited(body: Node) -> void:
	if body.name == "Player":
		is_in_area = false
		anim_player.play("label_fade_out")
		body.camera_zoom_out_dialog()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_in_area:
		set_process_unhandled_input(false)
		print("idk")
		#then we need to pause the game -> pause character control
		#zoom in to the character
		#instance dialogbox (Scene)
		#wait for the dialog to end (could be done wiht queue free and tree exited maybe)
		#zoom out
		#resume control of the character
