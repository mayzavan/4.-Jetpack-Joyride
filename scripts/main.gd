extends Node

@export var bullet_scene : PackedScene
@export var scientist_scene : PackedScene
@export var rocket_scene : PackedScene
@export var coin_scene : PackedScene
@export var beam_scene : PackedScene
@export var laser_scene : PackedScene

var screen_size
var scroll = 0
var scroll_sp = 0
var score = 0
var game_started = false
var hit = false
var coinsthisgame = 0
var recordbeaten = false

func _ready():
	$Music.play()
	Global.loadfile()
	$HUD.hide()
	$UI.show()
	$LostHUD.hide()
	screen_size = get_window().content_scale_size
	$floorbody/top.shape.a = (Vector2(0,16))
	$floorbody/top.shape.b = (Vector2(screen_size.x * 3,16))
	$floorbody/bottom.shape.a = (Vector2(0,screen_size.y-64))
	$floorbody/bottom.shape.b = (Vector2(screen_size.x * 3,screen_size.y-64))
	$UI/Coins.text = str(Global.coins)
	$UI/BestScore. text = ((str(int(Global.best)) + " m"))
	spawn_scientist(170)
	spawn_scientist(400)
	spawn_scientist(490)
	spawn_scientist(630)

func _process(delta):
	if hit == false:
		Global.mapspeed = scroll_sp
		if game_started == false and Input.is_action_just_pressed("fly"):
			start_game()
		elif game_started:
			scroll -= scroll_sp
			if scroll <= -screen_size.x:
				scroll = 0
			$floor.position.x = scroll
			if Input.is_action_pressed('fly'):
				shoot()
			score += 0.05
			$HUD/Score.text = (str(int(score)) + " m")
			if score >= Global.best:
				Global.best = score
				recordbeaten = true
			$HUD/BestScore.text = ("BEST: " + str(int(Global.best)))
			$HUD/Coins.text = str(coinsthisgame)
			if score <= 100:
				scroll_sp = 2
			elif score >100 and score <= 200:
				scroll_sp = 3
			elif score >200 and score <= 300:
				scroll_sp = 4
			elif score >300 and score <= 400:
				scroll_sp = 5
			elif score >400 and score <= 500:
				scroll_sp = 6
			elif score >500 and score <= 600:
				scroll_sp = 7
			elif score >600 and score <= 700:
				scroll_sp = 8
			elif score >900 and score <= 000:
				scroll_sp = 9
			elif score >000 and score <= 1000:
				scroll_sp = 10
			elif score >1000 and score <= 1100:
				scroll_sp = 11
			elif score >1100 and score <= 1200:
				scroll_sp = 12
	if hit == true and Input.is_action_just_pressed("fly"):
		await get_tree().create_timer(0.25, false).timeout
		play_again()
	

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2($character.position.x - 12, $character.position.y + 15)
	add_child(bullet)

func start_game():
	$selectSFX.play()
	$UI.hide()
	$HUD.show()
	$character.game_start()

func char_ready():
	game_started = true
	scroll_sp = 2
	$SpawnScientists.start()
	$DangerTimer.start()
	$Lasertimer.start()

func stolen():
	$coinSFX.play()
	coinsthisgame += 1

func spawn_scientist(posx):
	var scientist = scientist_scene.instantiate()
	scientist.position = Vector2(posx, 552)
	scientist.stolen.connect(stolen)
	add_child(scientist)

func _on_spawn_scientists_timeout():
	var amount = randf()
	if amount <= 0.3:
		amount = 2
	elif amount >0.3 and amount <= 0.6:
		amount = 3
	elif amount >0.6 and amount <=1:
		amount = 4
	for i in amount:
		spawn_scientist(screen_size.x + randi_range(20,200)*i)

func spawn_rocket(row, time):
	$dangerSFX.play()
	match row:
		0:
			$"Dangers/0".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 40)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/0".hide()
		1:
			$"Dangers/1".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/1".hide()
		2:
			$"Dangers/2".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/2".hide()
		3:
			$"Dangers/3".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/3".hide()
		4:
			$"Dangers/4".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/4".hide()
		5:
			$"Dangers/5".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/5".hide()
		6:
			$"Dangers/6".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/6".hide()
		7:
			$"Dangers/7".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/7".hide()
		8:
			$"Dangers/8".show()
			await get_tree().create_timer(time, false).timeout
			var rocket = rocket_scene.instantiate()
			rocket.position = Vector2(screen_size.x+100, 33 + 64 * row)
			rocket.hit.connect(game_lost)
			add_child(rocket)
			$"Dangers/8".hide()

func _on_danger_timer_timeout():
	var what = randf()
	if what >=0.55: #coins
		var which = randf()
		if which >= 0.8:
			spawn_coins(int(randf_range(0,5)),2)
		elif which < 0.8 and which >= 0.4:
			spawn_coins(int(randf_range(0,9)),1)
		else:
			spawn_coins(int(randf_range(0,5)),3)
	elif what < 0.45: #danger
		var whichdanger = randf()
		if whichdanger <= 0.1:
			spawn_beam(int(randf_range(0,9)))
			spawn_beam(int(randf_range(0,9)))
			spawn_beam(int(randf_range(0,9)))
			spawn_beam(int(randf_range(0,9)))
		elif whichdanger > 0.1 and whichdanger <= 0.3:
			spawn_rocket(int(randf_range(0,9)),0.5)
			spawn_rocket(int(randf_range(0,9)),0.5)
		elif whichdanger >0.3 and whichdanger <= 0.35:
			for i in 10:
				spawn_rocket(int(randf_range(0,9)),1)
				await get_tree().create_timer(0.2, false).timeout
		elif whichdanger >0.35 and whichdanger <= 0.4:
			for i in 4:
				spawn_beam(i)
				spawn_beam(8-i)
		elif whichdanger >0.4 and whichdanger <= 0.7:
			spawn_rocket(int(randf_range(0,9)),2)
			spawn_rocket(int(randf_range(0,9)),2)
			spawn_rocket(int(randf_range(0,9)),2)
			spawn_rocket(int(randf_range(0,9)),2)
		else:
			_on_lasertimer_timeout()

func spawn_coins(row, num):
	match num:
		1:
			for i in 10:
				var coin = coin_scene.instantiate()
				coin.position = Vector2(screen_size.x+100 + 30 * i, 33+ 64*row)
				coin.coined.connect(stolen)
				add_child(coin)
		2:
			for m in 5:
				for n in 5:
					var coin = coin_scene.instantiate()
					coin.position = Vector2(screen_size.x+100 + 30 * m, 33+ 64*row + 30*n)
					coin.coined.connect(stolen)
					add_child(coin)
		3:
			for m in 5:
				var coin = coin_scene.instantiate()
				coin.position = Vector2(screen_size.x+100 + 30 * m, 33+ 64*row + 30*m)
				coin.coined.connect(stolen)
				add_child(coin)

func game_lost():
	hit = true
	$hitSFX.play()
	scroll_sp = 0
	Global.mapspeed = 0
	$character.game_lost = true
	$DangerTimer.stop()
	$SpawnScientists.stop()
	Global.coins += coinsthisgame
	Global.savefile()
	$HUD.hide()
	$LostHUD.show()
	if recordbeaten == true:
		$LostHUD/NewRecord.show()
		$LostHUD/ScoreLabel.hide()
		$LostHUD/Score.hide()
	else:
		$LostHUD/NewRecord.hide()
		$LostHUD/ScoreLabel.show()
		$LostHUD/Score.show()
	$LostHUD/Coins.text = str(Global.coins)
	$LostHUD/BestScore.text = ((str(int(Global.best)) + " m"))
	$LostHUD/Score.text = (str(int(score)) + " m")
	$LostHUD/OldCoins.text = ('this run ' + str(coinsthisgame))

func play_again():
	$selectSFX.play()
	await get_tree().create_timer(0.5, false).timeout
	get_tree().reload_current_scene()

func spawn_beam(row):
	$Lasertimer.stop()
	$DangerTimer.stop()
	$SpawnScientists.stop()
	var beam = beam_scene.instantiate()
	beam.position = Vector2(32, 33 + 64 * row)
	beam.hit.connect(game_lost)
	add_child(beam)
	await get_tree().create_timer(3, false).timeout
	$DangerTimer.start()
	$SpawnScientists.start()
	$Lasertimer.start()

func spawn_laser(row, angle):
	var laser = laser_scene.instantiate()
	laser.position = Vector2(screen_size.x+100, 33 + 64 * row)
	laser.rotation_degrees = angle
	laser.hit.connect(game_lost)
	add_child(laser)

func _on_lasertimer_timeout():
	var rand = randf()
	if rand <= 0.25:
		spawn_laser(int(randf_range(0,9)),0.0)
	elif rand >0.25 and rand <= 0.5:
		spawn_laser(int(randf_range(0,7)),90.0)
	elif rand >0.5 and rand <= 0.75:
		spawn_laser(int(randf_range(0,7)),45.0)
	else:
		spawn_laser(int(randf_range(2,9)),-45.0)

