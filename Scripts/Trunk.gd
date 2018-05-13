extends Node2D

var speed = 1500
var direction = 1

onready var sprite = $TrunkMid
onready var leftAxe = $LeftAxe
onready var rightAxe = $RightAxe
onready var timer = $Timer

var spriteHeight

func _ready():
	spriteHeight = sprite.texture.get_height() * scale.y
	set_process(false)

func _process(delta):
	position.x += speed * direction * delta
	
func initTrunk(axe, right):
	if axe:
		if right:
			leftAxe.queue_free()
		else:
			rightAxe.queue_free()
	else:
		leftAxe.queue_free()
		rightAxe.queue_free()


func remove(fromRight):
	if fromRight:
		direction = -1
	else:
		direction = 1
	timer.start()
	set_process(true)
	
	
func _on_Timer_timeout():
	queue_free()