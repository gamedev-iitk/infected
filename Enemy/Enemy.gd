extends Area2D
signal enemy_killed
var direction = Vector2()
var screensize 
var follow = false
var distance
var speed = 0
var swarm = false
var enemySpeedMin = 50
var enemySpeedMax = 75
var enemyTimerMin = 5
var enemyTimerMax = 25
onready var player = get_node("/root/main/player")
func _ready():
   
	randomize()
	
	screensize = get_viewport_rect().size
   
	speed = rand_range(enemySpeedMin ,enemySpeedMax)
   
	follow = false
	swarm = 0
   
	$effect.interpolate_property(self, "scale", self.get_scale(),Vector2(.3,.3),0.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	$enemyTimer.wait_time = (rand_range(enemyTimerMin ,enemyTimerMax))
	
	$enemyTimer.start()
func _process(delta):   
	
	direction = player.position - self.position
	
	if direction.x > 0:
		self.get_node("enemy").set_flip_h(1)
	else:
		self.get_node("enemy").set_flip_h(0)
	distance = sqrt(direction.x * direction.x + direction.y * direction.y)
	
	if distance < 200:
		follow = true
	else:
		follow = false
		
	if follow == true or swarm > 100:   
		
		swarm += 1
		
		position += direction.normalized() * speed * delta
		position.x = clamp(position.x, 0, screensize.x)
		position.y = clamp(position.y, 0 , screensize.y)
func _on_enemy_area_enter( area ):
	
	if area.get_name()=="player":
		
		call_deferred("set_monitoring", false)
		
		if not $effect.is_active():
			$effect.start()
		
		emit_signal("enemy_killed")
func _on_effect_tween_completed( object, key ):
	
	queue_free()
func _on_enemytimer_timeout():
	
	if not $effect.is_active():
		$effect.start()
func _on_VisibilityNotifier2D_screen_exited():
   
	queue_free()
