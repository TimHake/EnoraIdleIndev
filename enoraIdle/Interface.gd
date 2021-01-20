extends VBoxContainer



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_Exploration_pressed():
	#Global.cPanel = "ExplorationPanel"
	_disablePanels()
	$ExplorationPanel.visible = true


func _on_Crafting_pressed():
	#Global.cPanel = "CraftingPanel"
	_disablePanels()
	$CraftingPanel.visible = true
	$CraftingPanel/CraftGrid.visible = true

func _on_Character_pressed():
	#Global.cPanel = "CharacterPanel"
	_disablePanels()
	$CharacterPanel.visible = true



func _on_SmithingButton_pressed():
	#Global.cPanel = "CraftingPanel"
	_disablePanels()
	$CraftingPanel.visible = true
	$CraftingPanel/SmithingVBoxContainer.visible = true


func _on_IronIngotButton_pressed():
	Global._setAction("smithing iron ingot")

func _disablePanels():
	#get_tree().call_group("panels", "_hide")
	$ExplorationPanel.visible = false
	$CraftingPanel.visible = false
	$CharacterPanel.visible = false
	$CraftingPanel/CraftGrid.visible = false
	$CraftingPanel/SmithingVBoxContainer.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
