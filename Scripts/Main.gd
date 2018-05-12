extends Node

export(PackedScene) var trunkScene
onready var firstTrunkPos = $FirstTrunkPos
var lastSpawnPos
var trunks = []


func _ready():
	lastSpawnPos = firstTrunkPos.position
	spawnFirstTrunks()
	
func spawnFirstTrunks():
	for counter in range(5):
		var newTrunk = trunkScene.instance()
		add_child(newTrunk)
		newTrunk.position = lastSpawnPos
		lastSpawnPos.y -= newTrunk.spriteHeight
		newTrunk.initTrunk(false, false)
		trunks.append(newTrunk)

func punchTree(fromRight):
	trunks[0].remove(fromRight)
	trunks.pop_front()



