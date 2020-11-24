extends Area2D

func _on_CollisionShape2D_body_entered(body):
	get_tree().change_scene('res://dialogue3LE.tscn')
