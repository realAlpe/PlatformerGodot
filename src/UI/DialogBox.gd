extends Control


var dialog = [
	"Despite all of this mess, I dont know what to do and it is quite bothering me.",
	"123123",
	"123123123"
]

onready var content = $TextureRect/RichTextLabel
var dialog_index = 0
var finished = false

func _ready() -> void:
	load_dialog()

func _process(_delta: float) -> void:
	$TextureRect/Finished_Button.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		content.text = dialog[dialog_index]
		content.percent_visible = 0
		$TextureRect/Tween.interpolate_property(
			content, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$TextureRect/Tween.start()
	else:
		remove_dialog()
	dialog_index += 1

func remove_dialog():
	queue_free()

func _on_Tween_completed(_object: Object, _key: NodePath) -> void:
	finished = true
