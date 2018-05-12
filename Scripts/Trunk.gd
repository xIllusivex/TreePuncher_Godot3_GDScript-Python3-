extends Node2D

onready var sprite = $TrunkMid
onready var leftAxe = $LeftAxe
onready var rightAxe = $RightAxe

var spriteHeight

func _ready():
	spriteHeight = sprite.texture.get_height() * scale.y
func initTrunk(axe, right):
	if axe:
		if right:
			leftAxe.queue_free()
		else:
			rightAxe.queue_free()
	else:
		leftAxe.queue_free()
		rightAxe.queue_free()