extends RigidBody2D

var speed = 75
export(Vector2) var start_pos
export(Vector2) var destination
export (PackedScene) var ShootSound
export (PackedScene) var TravelSound

var travelSound = null

func _ready():
	look_at(destination)
	self.global_position = start_pos
		
	# play shoot sound
	var shooting = ShootSound.instance()
	$Sounds.add_child(shooting)
	
	# play travel sound
	travelSound = TravelSound.instance()
	$Sounds.add_child(travelSound)
	
func _physics_process(delta):
	position += transform.x * speed * delta
	travelSound.position = position

func _on_Missle_body_entered(body):
	if body.is_in_group("enemies"):
		body.emit_signal("killed", body.position)
		queue_free()

func _on_MissleNotifier_screen_exited():
	queue_free()
