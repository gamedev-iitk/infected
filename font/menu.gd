extends Control


func _ready():
	pass 


func _on_New_game_pressed():
	global.health = 100
	global.enemies_killed = 0
	get_tree().change_scene("res://Cutscene/C1.tscn")
	


func _on_instructions_pressed():
	get_tree().change_scene("res://font/buttons/instruction.tscn")


func _on_exit_pressed():
	get_tree().quit()
