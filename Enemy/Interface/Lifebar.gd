extends HBoxContainer

func _on_Interface_health_changed(new_health):
	$TextureProgress.value = new_health
