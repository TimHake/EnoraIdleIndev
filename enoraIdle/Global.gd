extends Node


# Declare member variables here. Examples:
var xpReq = [0,
83,
174,
276,
388,
512,
650,
801,
969,
1154,
1358,
1584,
1833,
2107,
2411,
2746,
3115,
3523,
3973,
4470,
5018,
5624,
6291,
7028,
7842,
8740,
9730,
10824,
12031,
13363,
14833,
16456,
18247,
20224,
22406,
24815,
27473,
30408,
33648,
37224,
41171,
45529,
50339,
55649,
61512,
67983,
75127,
83014,
91721,
101333,
111945,
123660,
136594,
150872,
166636,
184040,
203254,
224466,
247886,
273742,
302288,
333804,
368599,
407015,
449428,
496254,
547953,
605032,
668051,
737627,
814445,
899257,
992895,
1096278,
1210421,
1336443,
1475581,
1629200,
1798808,
1986068,
2192818,
2421087,
2673114,
2951373,
3258594,
3597792,
3972294,
4385776,
4842295,
5346332,
5902831,
6517253,
7195629,
7944614,
8771558,
9684577,
10692629,
11805606,
13034431]

var actions = {
	"smithing iron ingot": {actionName = "smithing iron ingot", timeReq = 3, reward = "Iron Ingot", rewardQ = 1, rReq = 2, r1Req = "Iron Ore", r1ReqQ = 1, r2Req = "Coal Ore", r2ReqQ = 2, xpReward = 10, parentSkill = "smithing", progress = 0}
}

var gameTime = 0


# Called when the node enters the scene tree for the first time.



func _ready():
	print(Item.items["Fist"].name)
	Player._equipItem(Item.items["Fist"], "main hand")
	Player._equipItem(Item.items["Fist"], "off hand")
	Player._equipItem(Item.items["bare body"], "body")
	Player._equipItem(Item.items["bare legs"], "legs")
	Player._equipItem(Item.items["bare feet"], "feet")
	Player._equipItem(Item.items["bare arms"], "arms")
	Player._equipItem(Item.items["bare head"], "head")
	Player.load_character()
	Global._setAction("smithing iron ingot")
	get_tree().call_group("inventory", "_inventoryChanged")
	
	#if Global.gameTime == 0:
		#Global.gameTime = OS.get_unix_time()
	pass # Replace with function body.

func _timeUpdate():	
	var realTime = OS.get_unix_time()
	var timeDiff = (realTime - Global.gameTime)%60
	gameTime = realTime
	if Player.activeAction.actionName != "none":
		_simulateAction(Player.activeAction, timeDiff)
	#Player.xp["navigation"] += timeDiff
	#Player.level["navigation"] += Player._levelUpCheck(Player.level["navigation"], Player.xp["navigation"])
	#get_tree().call_group("NavLevel", "_textUpdate")
	

#func _findAction(action):
	#for i in actions:
		#f i.actionName == action:
			#return i

func _setAction(action):
	Player.activeAction = actions[action]

func _simulateAction(action, timeSpent):
	Player.activeAction.progress += timeSpent
	var preformed = Player.activeAction.progress / action.timeReq
	if preformed > 0:
		Player.activeAction.progress -= (preformed * action.timeReq)
		_preformAction(action, preformed)
	get_tree().call_group(Player.activeAction.actionName, "_update")
	
	
	
func _preformAction(action, preformed):
	var reqs = action.rReq
	var rLimiter = Item.items[action.r1Req]
	var rLimiterQ = action.r1ReqQ
	if reqs == 2:
		if (_resourceQuantity(rLimiter)/rLimiterQ) > (_resourceQuantity(Item.items[action.r2Req])/action.r2ReqQ):
			rLimiter =  Item.items[action.r2Req]
			rLimiterQ = action.r2ReqQ
	elif reqs == 3:
		if (_resourceQuantity(rLimiter)/rLimiterQ) > (_resourceQuantity(Item.items[action.r2Req])/action.r2ReqQ):
			rLimiter =  Item.items[action.r2Req]
			rLimiterQ = action.r2ReqQ
		elif (_resourceQuantity(rLimiter)/rLimiterQ) > (_resourceQuantity(Item.items[action.r3Req])/action.r3ReqQ):
			rLimiter =  Item.items[action.r3Req]
			rLimiterQ = action.r3ReqQ
	
	if rLimiterQ * preformed <= _resourceQuantity(rLimiter):
		if reqs == 1:
			Player._removeItem(action.r1Req, (preformed * action.r1ReqQ))
		elif reqs == 2:
			Player._removeItem(action.r1Req, (preformed * action.r1ReqQ))
			Player._removeItem(action.r2Req, (preformed * action.r2ReqQ))
		elif reqs == 3:
			Player._removeItem(action.r1Req, (preformed * action.r1ReqQ))
			Player._removeItem(action.r2Req, (preformed * action.r2ReqQ))
			Player._removeItem(action.r3Req, (preformed * action.r3ReqQ))
		Player.xp[action.parentSkill] += action.xpReward*preformed
	else:
		var numPreformed = int(_resourceQuantity(rLimiter) / rLimiterQ)
		if numPreformed == 0:
			print("not enough resources")
		elif reqs == 1:
			Player._removeItem(action.r1Req, (numPreformed*action.r1ReqQ))
		elif reqs == 2:
			Player._removeItem(action.r1Req, (numPreformed*action.r1ReqQ))
			Player._removeItem(action.r2Req, (numPreformed*action.r2ReqQ))
		elif reqs == 3:
			Player._removeItem(action.r1Req, (numPreformed*action.r1ReqQ))
			Player._removeItem(action.r2Req, (numPreformed*action.r2ReqQ))
			Player._removeItem(action.r3Req, (numPreformed*action.r3ReqQ))
		Player.xp[action.parentSkill] += action.xpReward*numPreformed
	Player.level[action.parentSkill] += Player._levelUpCheck(Player.level[action.parentSkill], Player.xp[action.parentSkill])
	_updateLevelText(action.parentSkill)
	Player._addItem(Item.items["Iron Ingot"], 1)
	pass
	
func _updateLevelText(skill):
	get_tree().call_group(skill, "_textUpdate")
	

func _resourceQuantity(r):
	for i in Player.inventory:
		if i.name == r.name:
			return i.quantity
			break
	return 0
	
func _progressBarUpdate(pBar):
	pBar.max_value = Player.activeAction.timeReq
	pBar.value = Player.activeAction.progress
	pBar.min_value = 0
	pass
	

func _levelBarUpdate(pBar, skill):
	pBar.max_value = Global.xpReq[Player.level[skill]]
	pBar.value = Player.xp[skill]
	if Player.level[skill] != 1:
		pBar.min_value = Global.xpReq[Player.level[skill]-1]
	else:
		pBar.min_value = 0
		
func _skillLevelLabelUpdate(label, skill):
	label.text = str(Player.level[skill]) + " / 99"

func _equipmentLabelUpdate(label, slot, base):
	label.text = base + Player.equipment[slot].name

func _populateInventory(itemList):
	itemList.clear()
	for i in Player.inventory:
		itemList.add_item(i.name + " x " + str(i.quantity))
	
	
func _attack(attackerL, weapon, defenderL):
	var hitChance
	hitChance = (70 + (attackerL[weapon] * 1.1)) - (defenderL["defense"] + 5)
	print("hit chance:")
	print(hitChance)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var number = rng.randf_range(1, 100)
	print(number)
	if number <= hitChance:
		print("hit!")
	else:
		print("miss!")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_timeUpdate()


func _on_Attack_pressed():
	_attack(Player.level, "sword",  Player.level)
