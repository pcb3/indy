class_name Player
extends CharacterBody2D

@export var player_data : ActorResource
@onready var jump_velocity : float = ((2.0 * player_data.jump_height) / player_data.jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * player_data.jump_height) / (player_data.jump_time_to_peak * player_data.jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * player_data.jump_height) / (player_data.jump_time_to_descent * player_data.jump_time_to_descent)) * -1.0
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	
	if not is_on_floor():
		if velocity.y < 0.0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * player_data.speed, player_data.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, player_data.friction * delta)

	move_and_slide()

	if Input.is_action_just_pressed("right"):
		animated_sprite.flip_h = true
	if Input.is_action_just_pressed("left"):
		animated_sprite.flip_h = false


func _on_hurt_box_body_entered(body: Node2D) -> void:
	print("player hit")
	#queue_free()
