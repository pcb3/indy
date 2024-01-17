extends Actor

@export var snake_data : ActorResource

@onready var animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var edge_checker = $RayCast2D

var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta	
	var found_ledge = not edge_checker.is_colliding()
	
	if found_ledge:
		direction *= -1

	velocity = snake_data.speed * direction
	
	move_and_slide()
