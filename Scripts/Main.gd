extends Node

export(PackedScene) var trunkScene
onready var firstTrunkPos = $FirstTrunkPos
var lastSpawnPos

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