extends KinematicBody2D

export(int) var MAX_MISSLES

export (PackedScene) var Missle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var mouse_pos = get_global_mouse_position()
	$TurrretTop.look_at(mouse_pos)
		
	if Input.is_action_just_pressed("shoot"):
		shoot(mouse_pos)
		
func shoot(destination):
	var missles = get_tree().get_nodes_in_group("missles")
	var missle_count = missles.size()
	if missle_count == MAX_MISSLES:
		return
		
	var m = Missle.instance()
	m.add_to_group("missles")
	m.destination = destination
	m.start_pos = position
	m.transform = $TurrretTop.global_transform
	owner.add_child(m)
