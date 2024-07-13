class_name Bullet extends CharacterBody2D

var pos
var speed = 500
var direction

func _ready():
	direction = randf_range(-20,20)
	rotation_degrees = -direction
	velocity = Vector2(speed*sin(deg_to_rad(direction)),abs(speed*cos(deg_to_rad(direction))))

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
