extends Node


var character_file = "user://character.save"

var gold = 0

var level = {
	"navigation": 1,
	"camping": 1,
	"sword": 1,
	"defense": 1,
	"smithing": 1
}

var xp = {
	"navigation": 1,
	"camping": 1,
	"sword": 1,
	"defense": 1,
	"smithing": 1
}

var equipment = {
	"main hand": {},
	"off hand": {},
	"body": {},
	"legs": {},
	"feet": {},
	"arms": {},
	"head": {},
	}
	
var inventory = [
	{name = "fist", quantity = 2},
	{name = "Oak Bow", quantity = 4},
	{name = "Iron Ore", quantity = 400},
	{name = "Coal Ore", quantity = 400}
]

var activeAction = {
	actionName = "none"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func save_character():
	var file = File.new()
	file.open(character_file, File.WRITE)
	file.store_var(Player.xp)
	file.store_var(Player.level)
	file.store_var(Player.equipment)
	file.store_var(Global.gameTime)
	file.store_var(Player.activeAction)
	file.store_var(Player.inventory)
	file.close()
	
func load_character():
	var file = File.new()
	if file.file_exists(character_file):
		file.open(character_file, File.READ)
		Player.xp = file.get_var()
		Player.level = file.get_var()
		Player.equipment = file.get_var()
		Global.gameTime = file.get_var()
		Player.activeAction = file.get_var()
		Player.inventory = file.get_var()
		file.close()
	if Global.gameTime == 0:
		Global.gameTime = OS.get_unix_time()

func _levelUpCheck(currentLevel, currentXP):
	var up = 0
	while currentXP > Global.xpReq[currentLevel]:
		up += 1
		currentLevel += 1
	return up
	
func _equipItem(item, slot):
	Player.equipment[slot] = item
	get_tree().call_group("equipment", "_textUpdate")
	
func _addItem(item, num):
	var c = false
	for i in Player.inventory:
		if i.name == item.name:
			i.quantity += num
			c = true
	if c:
		pass
	else:
		Player.inventory.append({name = item.name, quantity = num})
	get_tree().call_group("inventory", "_inventoryChanged")
	
func _removeItem(item, num):
	var newInv = [{}]
	for i in Player.inventory:
		if i.name == item:
			if num < i.quantity:
				i.quantity -= num
				newInv.append({name = i.name, quantity = i.quantity})
		else:
			newInv.append({name = i.name, quantity = i.quantity})
	newInv.remove(0)
	Player.inventory = newInv
	get_tree().call_group("inventory", "_inventoryChanged")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelUpNav_pressed():
	_equipItem(Item.items["Iron Sword"], "main hand")
	_addItem(Item.items["Iron Sword"], 2)
	Player.xp["navigation"] += 100
	Player.level["navigation"] += _levelUpCheck(Player.level["navigation"], Player.xp["navigation"])
	get_tree().call_group("navigation", "_textUpdate")

	
	save_character()


	


func _on_testButton_pressed():
	
	Global._simulateAction(Player.activeAction, 20)
