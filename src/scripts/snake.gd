extends Actor

@export var snake_data : ActorResource
@onready var animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var edge_check = $EdgeCheck
@onready var wall_check_right = $WallCheckRight
@onready var wall_check_left = $WallCheckLeft
@onready var hurt_box = $HurtBox

var direction = 1
var grounded = false

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity * delta
	
	var found_ledge = not edge_check.is_colliding()
	var found_wall = wall_check_right.is_colliding() or wall_check_left.is_colliding()
	
	if is_on_floor():
		grounded = true
	else: false
	
	if grounded and found_ledge or found_wall:
		direction *= -1
	
	velocity.x = snake_data.speed * direction
	
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("hit detected")
