extends Actor

@export var snake_data : ActorResource

@onready var animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var edge_checker = $RayCast2D

var direction := 1

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta
	
	if direction > 0:
		velocity.x = move_toward(velocity.x, direction * snake_data.speed, snake_data.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, direction * snake_data.speed, snake_data.acceleration * delta)
	
	move_and_slide()

	if edge_checker.get_collider() == null:
		print("null detected")
	else:
		direction *= -1
		animated_sprite.flip_h = true
