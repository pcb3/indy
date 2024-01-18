extends Actor

@export var snake_data : ActorResource
@onready var animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var edge_check = $EdgeCheck
@onready var wall_check_right = $WallCheckRight
@onready var wall_check_left = $WallCheckLeft

var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta	
	var found_ledge = not edge_check.is_colliding()
	var found_wall = wall_check_right.is_colliding() or wall_check_left.is_colliding()
	
	if found_ledge or found_wall:
		direction *= -1

	velocity = snake_data.speed * direction
	
	move_and_slide()
	
	
