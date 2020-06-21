extends KinematicBody2D

const GRAVITY = 1400.0
const JUMP_POWER = -400
const SPEED = 160
const FRICTION = 0.1
const ACCELERATION = 0.1

onready var anim_sprite: = get_node("AnimatedSprite")
onready var tele_posi: = get_node("TeleportPosition")
onready var timer_node: = get_node("PorterTimer")
onready var spike_detec: = $SpikeDetector

var final_tele_posi: = Vector2(0, 0)

var velocity = Vector2.ZERO
var jump_count = 0
var dash_count = 0
var is_dashing = false
var keys = 0

func _physics_process(delta: float) -> void:
	
	var input_velocity = Vector2.ZERO
	var direction = Vector2.ZERO
	
	if is_on_floor():
		jump_count = 0
		dash_count = 0
		is_dashing = false
	
	
	#Gets the input from the player
	if Input.is_action_pressed("ui_right"):
		input_velocity.x += 1
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		input_velocity.x -= 1
		direction.x = -1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_just_pressed("jump") and not is_on_floor() and dash_count < 1:
		is_dashing = true
		if direction.x == 1:
			velocity.x -= JUMP_POWER
			velocity.y += JUMP_POWER * 0.5
			dash_count += 1
		elif direction.x == -1:
			velocity.x += JUMP_POWER
			velocity.y += JUMP_POWER * 0.5
			dash_count += 1
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		jump_count += 1
		velocity.y += JUMP_POWER - 128
	
	
	#Calculating the velocity
	velocity.y += GRAVITY * delta
	input_velocity = input_velocity.normalized() * SPEED
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, ACCELERATION)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	#Applying the animation
	if direction.x == 1 and velocity.y < 0:
		anim_sprite.set_flip_h(false)
	if direction.x == 1 and velocity.y > 0:
		anim_sprite.set_flip_h(false)
	if direction.x == -1 and velocity.y < 0:
		anim_sprite.set_flip_h(true)
	if direction.x == -1 and velocity.y > 0:
		anim_sprite.set_flip_h(true)
	
	if velocity.y < 0:
		anim_sprite.play("jump_anim")
	elif velocity.y > 0:
		anim_sprite.play("fall_anim")
	elif direction.x == 1:
		anim_sprite.set_flip_h(false)
		anim_sprite.play("walk_anim")
	elif direction.x == -1:
		anim_sprite.set_flip_h(true)
		anim_sprite.play("walk_anim")
	else:
		anim_sprite.play("idle_anim")
	
	
func _on_PorterDetector_area_entered(area: Area2D) -> void:
	if area.name == "Area2D":
		timer_node.start()

func _on_PorterTimer_timeout() -> void:
	final_tele_posi = tele_posi.position + position
	position = final_tele_posi
	dash_count = 0
	timer_node.stop()


func _on_SpikeDetector_area_entered(area: Area2D) -> void:
	if area.name != "PorterDetector":
		if area.name != "Area2D":
			if area.name != "key":
				if area.name != "area":
					if area.name != "JumpPadArea":
						if area.name != "CrystalArea":
							if area.name != "CrystalArea2":
								if area.name != "CrystalArea3":
									if area.name != "CrystalArea4":
											die()

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
	
