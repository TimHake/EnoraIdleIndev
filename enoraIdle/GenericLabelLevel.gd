extends Label


# Declare member variables here. Examples:
var skill = "SKILL"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _textUpdate():
	Global._skillLevelLabelUpdate(self, skill)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

