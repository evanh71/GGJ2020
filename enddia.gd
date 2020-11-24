extends RichTextLabel

export var dialog = ['Seems quiet...']
var page = 0
var decision_time = false
var leave_time = false

signal black
# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event):
	# handles the input from the player
	
	if event is InputEventKey and event.pressed:
		# if the space bar is pressed, advance the text at the end of the messa
		if event.scancode == KEY_SPACE:
			if get_visible_characters() > get_total_character_count():
				get_tree().change_scene('res://credits.tscn')
	
func _on_Timer_timeout():
	# every 0.05 seconds, display a new character
	set_visible_characters(get_visible_characters()+1)
