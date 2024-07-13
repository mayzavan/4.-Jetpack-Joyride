extends CharacterBody2D

signal hit

func _process(delta):
	var collision = move_and_collide(Vector2(-Global.mapspeed, 0))
	if collision:
		var collider = collision.get_collider()
		if collider is Character:
			queue_free()
			hit.emit()
	if position.x <=-100:
		queue_free()
