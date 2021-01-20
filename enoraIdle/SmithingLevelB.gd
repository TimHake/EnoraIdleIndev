extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skill = "smithing"

# Called when the node enters the scene tree for the first time.
func _ready():
	Global._levelBarUpdate(self, skill)
		
	pass

func _textUpdate():
	Global._levelBarUpdate(self, skill)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

