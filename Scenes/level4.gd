extends Node2D

func _physics_process(delta):
	if global.enemies_killed == 66 :
		get_tree().change_scene("res://font/buttons/End.tscn")
