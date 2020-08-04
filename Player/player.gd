extends KinematicBody2D

const ACCN = 200
const MAX_SPEED = 80
const FRICTION = 300
const GRAVITY = 400 #for jump action

const bullet_scene = preload("res://Scenes/Bullet.tscn")

onready var animationPlayer = $AnimationPlayer

var velocity = Vector2.ZERO
var last_direction = 0
var on_ground = 1
var jump_count = 1
var level = 1


func _physics_process(delta):
	#movement input direction
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# movement in x direction
	if direction.x :
		last_direction = direction.x
		if direction.x > 0 :
			animationPlayer.play("infected player right")
		else :
			animationPlayer.play("infected player left")
		velocity.x += direction.x * ACCN * delta
		velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	else:
		velocity.x = move_toward(velocity.x,0,FRICTION * delta)
		if last_direction >= 0 :
			animationPlayer.play("ideal right")
		else :
			animationPlayer.play("ideal left")
	
	#movement in y direction
	if Input.is_action_just_pressed("ui_up"):
		if jump_count:
			velocity.y = -250
			jump_count -= 1
	else :
		velocity.y += GRAVITY * delta
		velocity.y = clamp(velocity.y,-150,200)
	if is_on_floor():
		jump_count = 1
		
	move_and_slide(velocity,Vector2(0,-1))
	
	#hitting bullet
	if Input.is_action_just_pressed("LeftMouse"):
		_shoot()

func _shoot() : 
	var flag = 1
	var mouse_pos = get_global_mouse_position()
	var l_ancor = get_node("AncorLeft").get_global_position()
	var r_ancor = get_node("AncorRight").get_global_position()
	var bullet_pos = r_ancor
	if mouse_pos.x > r_ancor.x :
		bullet_pos = r_ancor
		$Sprite.frame = 4
#		animationPlayer.play("shoot right")
	elif mouse_pos.x < l_ancor.x :
		bullet_pos = l_ancor
		$Sprite.frame = 5
#		animationPlayer.play("shoot left")
	else :
		flag = 0
	if flag :
		var bullet = bullet_scene.instance()
		get_tree().get_root().add_child(bullet)
		bullet.start_pos = bullet_pos
		bullet.mouse_pos = mouse_pos
		bullet.set_position(bullet_pos)


func enemy_in_contact(damage):
	if (global.health - damage)<=100 :
		global.health -= damage
	if global.health <= 0 :
		queue_free()
		get_tree().change_scene("res://font/menu.tscn")
	#game over
