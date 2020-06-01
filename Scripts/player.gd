
extends KinematicBody2D
const friction = 80
const MAX_SPEED = 200
const ACCELERATION = 800
var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer 

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")*2 - Input.get_action_strength("ui_left")*2
	input_vector.y = Input.get_action_strength("ui_down")*2 - Input.get_action_strength("ui_up")*2
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationPlayer.play("infected player right")
		else:
			animationPlayer.play("infected player left")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("ideal right")
		
	if velocity != input_vector:
		if input_vector == Vector2.ZERO:
			velocity = velocity.move_toward(Vector2.ZERO,friction*delta)
		else:
			
			velocity += input_vector*delta
			velocity =  velocity.clamped(70*delta)
	  
	else:
		velocity = Vector2.ZERO
	 
	move_and_slide(velocity*100)#move in direction of velocity vector and stop there any collision happen
	  
	
