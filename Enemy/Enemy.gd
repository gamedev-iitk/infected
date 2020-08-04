extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0,-1)

export(int) var hp = 2
export(int) var speed = 60
export(int) var damage = 5


var velocity = Vector2()
var direction=1

var is_dead = false
var timeout_flag = 0


func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("player"):
				if timeout_flag == 0 :
					$PlayerHit.start()
					timeout_flag = 1
			elif collision.normal.y == 0:
				direction *= -1
				$RayCast2D.position.x *= -1
	
	if direction == 1:
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)
	
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
		global.enemies_killed += 1

func _on_Timer_timeout():
	queue_free()

func _on_PlayerHit_timeout():
	get_tree().call_group("player", "enemy_in_contact", damage)
	timeout_flag = 0
