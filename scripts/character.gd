class_name Character extends CharacterBody2D

var GRAVITY = 100
var xspeed = 400
var yspeed = -100
var starting_position: Vector2
var game_started
var game_lost

signal hit
signal letsgo
signal coined

func _ready():
	game_lost = false
	game_started = false
	starting_position = Vector2(300,544) 
	self.position = Vector2(-15,544)

func game_start():
	velocity = Vector2(xspeed, 0)


func _process(delta):
	if game_lost == false:
		if game_started == false:
			$Sprite2D.play('walking')
			position += velocity * delta
			if position.x >= 300:
				velocity.x = 0
				letsgo.emit()
				game_started = true
			
		if game_started:
			velocity.y = clamp(velocity.y, -750,1000)
			if Input.is_action_just_pressed("fly"):
				$MoveDown.stop()
				velocity.y = yspeed
				$shotSFX.play()
				$MoveUp.start()
			elif Input.is_action_just_released('fly'):
				$MoveUp.stop()
				velocity.y = 0
				await get_tree().create_timer(0.025, false).timeout
				$MoveDown.start()
			if position.y >= 543:
				$Sprite2D.play('walking')
			else:
				$Sprite2D.animation = 'flying'
			var collision = move_and_collide(Vector2(0, velocity.y * delta))
			if collision:
				var collider = collision.get_collider()
				if collider is Beam or collider is Rocket:
					game_lost=true
					hit.emit()
					collider.queue_free()
				elif collider is Coin:
					collider.queue_free()
					coined.emit()
	elif game_lost == true:
		position.y += 300*delta
		$shotSFX.playing = false
 
func flying():
	velocity.y += yspeed
	$shotSFX.play()

func falling():
	velocity.y += GRAVITY
