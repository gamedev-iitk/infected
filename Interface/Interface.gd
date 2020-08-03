extends Control

var health = global.health

func _physics_process(delta):
	$CanvasLayer/Lifebar/TextureProgress.value = global.health
	$CanvasLayer/Lifebar/Tween.interpolate_property($CanvasLayer/Lifebar/TextureProgress, "value", health, global.health, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$CanvasLayer/Lifebar/Tween.start()
	health = global.health
	$CanvasLayer/EnemyCounter/Label.text = str(global.enemies_killed)
