extends Area2D

const SPEED = 4
var start_pos = Vector2(0,0)
var mouse_pos = Vector2(0,0)


func _physics_process(delta):
	if start_pos == Vector2.ZERO :
		queue_free()
	var direction = (mouse_pos - start_pos).normalized()
	var distance =  get_position() - start_pos
	if distance.length() > 60 :
		queue_free()
	translate(SPEED*direction)

func _on_Bullet_body_entered(body):
	queue_free()
	if "Enemy" in body.name:
		body.On_hit_and_dead()
	if "Breakable" in body.name:
		body.queue_free()

