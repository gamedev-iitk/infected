extends Control

signal health_changed(new_health)

func _on_Player_health_changed(new_health):
	emit_signal("health_changed",new_health)
