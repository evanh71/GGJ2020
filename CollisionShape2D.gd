extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_CollisionShape2D_body_entered(body):
	get_tree().change_scene('res://Dialogue1.tscn')
