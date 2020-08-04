extends Node2D

func _physics_process(delta):
	
	if get_node("Player").get_node("AncorRight").get_global_position().x>640 :
		get_tree().change_scene("res://Scenes/level2.tscn")
