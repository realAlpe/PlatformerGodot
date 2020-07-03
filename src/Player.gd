extends KinematicBody2D

const GRAVITY = 1400.0
const JUMP_POWER = -400
const SPEED = 160
const FRICTION = 0.1
const ACCELERATION = 0.1

onready var anim_sprite: = get_node("AnimatedSprite")
onready var spike_detec: = $SpikeDetector
onready var camera = $CameraPivot/Camera2D

var is_inside_conveyor_area = false
var final_tele_posi = Vector2(0, 0)
var velocity = Vector2.ZERO
var dash_count = 0
var is_dashing = false
var keys = 0
var looking_right = true
var hold_time_down = 0.0
var hold_time_up = 0.0
var camera_changed_down = false
var camera_changed_up = false
var test = 0

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	if is_on_floor():
		dash_count = 0
		is_dashing = false
	
	#Gets the input from the player
	if Input.is_action_pressed("ui_right"):
		anim_sprite.set_flip_h(false)
		looking_right = true
		
		direction.x = 1
		
		test += 1
		test = min(20, test)
		$CameraPivot.position.x = test
	if Input.is_action_pressed("ui_left"):
		anim_sprite.set_flip_h(true)
		looking_right = false
		
		direction.x = -1
		
		test -= 1
		test = max(-20, test)
		$CameraPivot.position.x = test
	if Input.is_action_just_pressed("jump") and not is_on_floor() and dash_count < 1:
		is_dashing = true
		dash_count += 1
		
		velocity.y += JUMP_POWER * 0.5
		if looking_right:
			velocity.x -= JUMP_POWER
		if not looking_right:
			velocity.x += JUMP_POWER
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_POWER - 128
	
	if is_inside_conveyor_area:
		velocity.x += 16
	
	#Calculating the velocity
	velocity.y += GRAVITY * delta
	if direction != Vector2.ZERO:
		velocity = velocity.linear_interpolate(direction * SPEED, ACCELERATION)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION)
	velocity = move_and_slide(velocity, Vector2.UP)

	
	#Applying the animation
	if velocity.y < 0:
		anim_sprite.play("jump_anim")
	elif velocity.y > 0:
		anim_sprite.play("fall_anim")
	elif direction.x == 1 or direction.x == -1:
		anim_sprite.play("walk_anim")
	else:
		anim_sprite.play("idle_anim")
	
	
	#Changes the camera to look up or down after holding a while
	if Input.is_action_pressed("ui_down") and is_on_floor():
		hold_time_down += delta
		if hold_time_down >= 0.5:
			camera_changed_down = true
			camera.position.y = 80
	elif Input.is_action_just_released("ui_down") and camera_changed_down or not is_on_floor():
		camera_changed_down = false
		camera.position.y = 0
		hold_time_down = 0
	if Input.is_action_pressed("ui_up") and is_on_floor():
		hold_time_up += delta
		if hold_time_up >= 0.5:
			camera_changed_up = true
			camera.position.y = -80
	elif Input.is_action_just_released("ui_up") and camera_changed_up or not is_on_floor():
		camera_changed_up = false
		camera.position.y = 0
		hold_time_up = 0
	
	
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


func _on_ghost_timer_timeout() -> void:
	#Creates a trail of sprites behind the Player after he dashes
	if is_dashing:
		var this_ghost = preload("res://src/Objects/ghost.tscn").instance()
		get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = anim_sprite.frames.get_frame(anim_sprite.animation, anim_sprite.frame)
		this_ghost.flip_h = anim_sprite.flip_h
		this_ghost.scale = anim_sprite.scale
		this_ghost.modulate = Color(1, 1, 1, 1)

