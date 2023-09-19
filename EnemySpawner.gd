extends Node3D

@export var EnemyToSpawn: PackedScene

func _on_ready():
	_on_timer_timeout()

func _on_timer_timeout():
	var new_enemy = EnemyToSpawn.instantiate()
	new_enemy.transform.origin = transform.origin + Vector3(randf_range(-15, 15), randf_range(-10, 10), 0)
	add_child(new_enemy)


