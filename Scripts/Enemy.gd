extends RigidBody2D

var speed = 50
export(Vector2) var start_pos
export(Vector2) var destination
export(PackedScene) var Explosion

signal killed(position)

func _ready():
	get_node("EnemyNotifier").connect("screen_exited", self, "_on_screen_exited")
	look_at(destination)
	self.global_position = start_pos
	
func _physics_process(delta):
	position += transform.x * speed * delta
	
func _on_Enemy_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_screen_exited():
	die()

func die():
	queue_free()
	
func _on_Enemy_killed(position):
	var explosion = Explosion.instance()
	explosion.add_to_group("explosions")
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
	
	
