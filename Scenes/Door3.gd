extends StaticBody2D

func _physics_process(delta):
	if global.enemies_killed == 46 :
		queue_free()
