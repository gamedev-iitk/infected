extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0,-1)

export(int) var hp = 1
export(int) var speed = 50
var velocity = Vector2()
var direction = 1

var is_dead = false

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		
	if direction == 1:
		$Sprite.flip_h == false
	else:
		$Sprite.flip_h == true
		
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1

func On_hit_and_dead():
	hp -= 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$CollisionShape2D.disabled = true
		$Timer.start()

func _on_Timer_timeout():
	queue_free()
