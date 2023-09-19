extends CharacterBody3D

func _physics_process(delta):
	move_and_slide()
	
	if abs(transform.origin.z) > 300:
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		body.queue_free()
		queue_free()
