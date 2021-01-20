extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var items = [
	#{itemType = "weapon", name = "Fist", attack = 1, accuracy = .9, type = "unarmed", twoHanded = false},
	#{itemType = "weapon", name = "Iron Sword", attack = 5, accuracy = 1.1, type = "sword", twoHanded = false},
	#{itemType = "weapon", name = "Oak Bow", attack = 20, accuracy = 2.0, type = "bow", twoHanded = true},
	
	
	#{itemType = "armor", name = "bare body", defense = 0, type = "unarmored", slot = "body"},
	#{itemType = "armor", name = "bare legs", defense = 0, type = "unarmored", slot = "legs"},
	#{itemType = "armor", name = "bare feet", defense = 0, type = "unarmored", slot = "feet"},
	#{itemType = "armor", name = "bare arms", defense = 0, type = "unarmored", slot = "arms"},
	#{itemType = "armor", name = "bare head", defense = 0, type = "unarmored", slot = "head"},
	
	#{itemType = "resource", name = "Iron Ore", value = 2},
	#{itemType = "resource", name = "Coal Ore", value = 2}
#]

var items = {
	"Fist": {itemType = "weapon", name = "Fist", attack = 1, accuracy = .9, type = "unarmed", twoHanded = false},
	"Iron Sword": {itemType = "weapon", name = "Iron Sword", attack = 5, accuracy = 1.1, type = "sword", twoHanded = false},
	"Oak Bow": {itemType = "weapon", name = "Oak Bow", attack = 20, accuracy = 2.0, type = "bow", twoHanded = true},
	
	
	"bare body": {itemType = "armor", name = "bare body", defense = 0, type = "unarmored", slot = "body"},
	"bare legs": {itemType = "armor", name = "bare legs", defense = 0, type = "unarmored", slot = "legs"},
	"bare feet": {itemType = "armor", name = "bare feet", defense = 0, type = "unarmored", slot = "feet"},
	"bare arms": {itemType = "armor", name = "bare arms", defense = 0, type = "unarmored", slot = "arms"},
	"bare head": {itemType = "armor", name = "bare head", defense = 0, type = "unarmored", slot = "head"},
	
	"Iron Ore": {itemType = "resource", name = "Iron Ore", value = 2},
	"Iron Ingot": {itemType = "resource", name = "Iron Ingot", value = 4},
	"Coal Ore": {itemType = "resource", name = "Coal Ore", value = 2}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#func _findItem(itemName):
	#for i in items:
		#if i.name == itemName:
			#return i
	#return items[0]
	
#func _altFindItem(itemName):
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
