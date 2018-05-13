extends Node

export(PackedScene) var trunkScene

onready var firstTrunkPos = $FirstTrunkPos
onready var grave = $Grave
onready var timeLeft = $TimeLeft
onready var player = $Player
onready var timer = $Timer

var lastSpawnPos
var lastHasAxe= false
var lastAxeRight = false
var trunks = []
var dead = false

func _ready():
	lastSpawnPos = firstTrunkPos.position
	spawnFirstTrunks()

func _process(delta):
	if dead:
		return
	timeLeft.value -= delta
	if timeLeft.value <= 0:
		die()

func spawnFirstTrunks():
	for counter in range(5):
		var newTrunk = trunkScene.instance()
		add_child(newTrunk)
		newTrunk.position = lastSpawnPos
		lastSpawnPos.y -= newTrunk.spriteHeight
		newTrunk.initTrunk(false, false)
		trunks.append(newTrunk)

func addTrunk(axe, axePos):
	var newTrunk = trunkScene.instance()
	add_child(newTrunk)
	newTrunk.position = lastSpawnPos
	newTrunk.initTrunk(axe, axePos)
	trunks.append(newTrunk)

func punchTree(fromRight):
	if !lastHasAxe:
		if rand_range(0, 100) > 50:
			lastAxeRight = rand_range(0, 100) > 50
			lastHasAxe = true
		else:
			lastHasAxe = false
	else:
		if rand_range(0, 100) > 50:
			lastHasAxe = true
		else:
			lastHasAxe = false
	addTrunk(lastHasAxe, lastAxeRight)

	trunks[0].remove(fromRight)
	trunks.pop_front()
	for trunk in trunks:
		trunk.position.y += trunk.spriteHeight
	timeLeft.value += 0.25
	if timeLeft.value > timeLeft.max_value:
		timeLeft = timeLeft.max_value

func die():
	grave.position.x = player.position.x
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true

func _on_Timer_timeout():
	get_tree().reload_current_scene()
