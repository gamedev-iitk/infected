extends StaticBody2D

func _physics_process(delta):
	if global.enemies_killed == 23 :
		queue_free()
