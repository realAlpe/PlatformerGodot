tool
extends Area2D

signal entered

onready var anim_player: AnimationPlayer = $TransitionLayer/FadeInTransition/AnimationPlayer
export var next_scene: PackedScene

func _ready() -> void:
	$TransitionLayer/FadeInTransition.visible = false

func _on_body_entered(body: Node) -> void:
	emit_signal("entered")
	var hurtbox = body.get_node("SpikeDetector")
	hurtbox.monitoring = false
	teleport()

func teleport() -> void:
	$AnimationPlayerRed.play("turn_red")
	anim_player.play("fade_out_transition")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning() -> String:
	return "The next scene property cannot be empty." if not next_scene else ""
