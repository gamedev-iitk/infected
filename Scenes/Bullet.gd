extends KinematicBody2D

const SPEED = 5
var start_pos = Vector2(0,0)
var mouse_pos = Vector2(0,0)


func _physics_process(delta):
	if start_pos == Vector2.ZERO :
		queue_free()
	var direction = (mouse_pos - start_pos).normalized()
	var distance =  get_position() - start_pos
	if distance.length() > 100 :
		queue_free()
	var collision_info = move_and_collide(SPEED*direction)
	if collision_info :
		queue_free()
		if collision_info.collider.name == "Enemy" :
			print("Hit")
