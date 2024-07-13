class_name Rocket extends CharacterBody2D

var speed = -1200
signal hit

func _process(delta):
	var collision = move_and_collide(Vector2(speed*delta,0))
	if collision:
		var collider = collision.get_collider()
		if collider is Character:
			hit.emit()
			queue_free()
	if position.x <= 0:
		queue_free()
