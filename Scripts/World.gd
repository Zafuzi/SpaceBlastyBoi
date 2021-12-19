extends Node2D


var timer = 0
var projectResolution = Vector2(0,0)

export(PackedScene) var Enemy
export(int) var MAX_ENEMIES
export(int) var score

func _ready():
	projectResolution = get_viewport_rect().size
	#print(projectResolution)

func _process(delta):
	timer += 1
	var missles = get_tree().get_nodes_in_group("missles")
	
	#print(missles.size())
	$GUI/MissleCount.text = "AMMO : " + str($Player.MAX_MISSLES - missles.size())
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	var enemy_count = enemies.size()
	if enemy_count == MAX_ENEMIES:
		return
		
	if timer % 100 == 0:
		var e = Enemy.instance()
		e.add_to_group("enemies")
		
		randomize()
		var spawnLeft = floor(rand_range(0,2))

		if spawnLeft == 1:
			e.position = Vector2(rand_range(-100, -30), rand_range(-30, projectResolution.y + 30))
		else:
			e.position = Vector2(rand_range(projectResolution.x + 30, projectResolution.x + 100), rand_range(-30, projectResolution.y + 30))
			
		e.destination = $Player.position
		e.start_pos = e.position
		e.connect("killed", self, "_on_Enemy_Killed")
		$Enemies.add_child(e)
	
	if Input.is_action_just_pressed("ui_escape"):
		get_tree().change_scene("res://GameOver.tscn")

func _on_Enemy_Killed(position):
	score += 1
	$GUI/Score.text = "Score : " + str(score)
	
