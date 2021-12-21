extends Control



func _on_PlayAgain_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
