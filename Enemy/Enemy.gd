extends KinematicBody2D

const GRAVITY = 10
#const FLOOR = Vector2(0,-1)

export(int) var hp = 1
export(int) var speed = 60
var velocity = Vector2()
var direction=1

var is_dead = false
var timeout_flag = 0
signal player_in_contact(damage)	

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, Vector2(0, -1))
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("player"):
				if timeout_flag == 0 :
					$PlayerHit.start()
					timeout_flag = 1
			elif collision.collider.name == "Bullet" :
				On_hit_and_dead()
			elif collision.normal.y == 0:
				direction *= -1
				$RayCast2D.position.x *= -1
			
	if direction == 1:
		$Sprite.flip_h == false
	else:
		$Sprite.flip_h == true
		
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1

func On_hit_and_dead():
	hp -= 1
	if hp <= 0:
		queue_free()
		is_dead = true
		velocity = Vector2(0,0)
		$CollisionShape2D.disabled = true
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

func _on_PlayerHit_timeout():
	get_tree().call_group("player", "enemy_in_contact", 5)
	timeout_flag = 0
