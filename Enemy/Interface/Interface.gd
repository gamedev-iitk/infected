extends Control

func _on_Player_health_changed(new_health):
	$Lifebar/TextureProgress.value = new_health
