extends CharacterBody3D

var movement_speed: float = randf_range(40,80)

func _physics_process(delta):
	velocity.z = movement_speed
	move_and_slide()
	
	if transform.origin.z > 200:
		queue_free()


