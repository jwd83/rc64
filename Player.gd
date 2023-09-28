extends CharacterBody3D

const MAX_SPEED = 30
const ACCELERATION = 0.65
var COOLDOWN_RESET = 0.10
var cooldown = 0
var bobble : float = 0

var input_vector = Vector3()

@export var BulletScene: PackedScene

func _ready():
	# move down slightly when we enter the world
	velocity.y = -20

func _physics_process(delta):
	
	# get the movement inputs
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	# normalize the input vector
	input_vector = input_vector.normalized()
	
	# update velocity
	velocity.x = move_toward(velocity.x, input_vector.x * MAX_SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, input_vector.y * MAX_SPEED, ACCELERATION)

	# rotate the ship based on velocity
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.x = velocity.y / 2
	rotation_degrees.y = -velocity.x / 2
	
	
	# move the ship
	move_and_slide()

	# prevent leaving the screen
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		cooldown = COOLDOWN_RESET
		var new_bullet = BulletScene.instantiate()
		
		new_bullet.transform.origin = get_node("/root/Game/Player").transform.origin + $Gun1.transform.origin
		new_bullet.rotation = get_node("/root/Game/Player").rotation
		new_bullet.velocity = new_bullet.transform.basis.z * -250
		get_node("/root/Game").add_child(new_bullet)
		
	cooldown -= delta
		
		
