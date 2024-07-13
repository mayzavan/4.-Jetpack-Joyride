class_name Scientist extends CharacterBody2D

var speed = 0.75
var speedx = 0
var coin_velocity

signal stolen

func _ready():
	coin_velocity = 0
	var a = randi()%2
	if a == 1:
		speed = speed
	else:
		speed = -speed
		scale.x = -3

func _process(delta):
	position.y = clamp(position.y, 548, 569)
	var collision = move_and_collide(Vector2((speed - Global.mapspeed), speedx))
	$coin.position.x -= coin_velocity
	if $coin.position.x == -25:
		$coin.hide()
	if collision:
		rotation_degrees = 90
		speedx = 0.5
	if position.y >= 567:
		speedx = 0
		speed = 0
	if position.y == 548:
		$coin.show()
		coin_velocity = 1
		stolen.emit()
	if position.x <= 0:
		queue_free()
