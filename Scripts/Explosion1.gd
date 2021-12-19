extends AnimatedSprite

func _ready():
	play("idle")

func _process(delta):
	if not is_playing():
		queue_free()
	pass
