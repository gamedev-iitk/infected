extends StaticBody2D


func _physics_process(delta):
	if global.enemies_killed == 8 :
		queue_free()
