extends Node

var save_best = "user://best.save"
var save_coins = "user://coins.save"

var best = 0
var coins = 0
var mapspeed = 0

func savefile():
	var file = FileAccess.open(save_best, FileAccess.WRITE)
	file.store_var(best)
	var file2 = FileAccess.open(save_coins, FileAccess.WRITE)
	file2.store_var(coins)
	print("game saved")

func loadfile():
	if FileAccess.file_exists(save_best):
		print("best loaded")
		var file = FileAccess.open(save_best, FileAccess.READ)
		best = file.get_var()
		
	else:
		print("best not found")
		best = 0
		
	if FileAccess.file_exists(save_coins):
		print("coins loaded")
		var file2 = FileAccess.open(save_coins, FileAccess.READ)
		coins = file2.get_var()
		
	else:
		print("coins not found")
		coins = 0
