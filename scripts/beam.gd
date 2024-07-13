class_name Beam extends Sprite2D

signal hit

func _ready():
	$Area2D.monitoring = false
	$laser.scale.y = 1
	await get_tree().create_timer(1, false).timeout
	$beamSFX.play()

func _process(delta):
	await get_tree().create_timer(1, false).timeout
	$Area2D.monitoring = true
	$laser.scale.y = 5
	await get_tree().create_timer(1.5, false).timeout
	queue_free()

func _on_area_2d_body_entered(body):
	if body is Character:
		hit.emit()
