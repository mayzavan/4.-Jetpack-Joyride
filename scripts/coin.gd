class_name Coin extends CharacterBody2D

signal coined

func _process(delta):
	var collision = move_and_collide(Vector2(-Global.mapspeed, 0))
	if collision:
		var collider = collision.get_collider()
		if collider is Character:
			queue_free()
			coined.emit()
	if position.x <=0:
		queue_free()
