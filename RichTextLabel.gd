extends RichTextLabel

export var dialog = ['testing testing 1 2 3','my name is kaifin osu', 'stream duality by living suitcase', 'press 1 or 2 to view some paths']
var initial = dialog
export var PATH1 = ['this is path 1', 'you have chose this path', 'foolish of you']
export var PATH2 = ['this is path 2', 'what will you do', 'foolish of you']
var page = 0
var decision_time = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event):
	# handles the input from the player
	if event is InputEventKey and event.pressed:
		# if the space bar is pressed, advance the text at the end of the message
		if event.scancode == KEY_SPACE:
			if get_visible_characters() > get_total_character_count():
				if page < dialog.size()-1:
					page += 1
					set_bbcode(dialog[page])
					set_visible_characters(0)
		# if 1 is pressed during decision time, activate path 1
		elif event.scancode == KEY_1 and decision_time:
			decision_time = false
			dialog = PATH1
			page = 0
			set_bbcode(dialog[page])
			set_visible_characters(0)
			
		# if 2 is pressed during decision time, activate path 2
		elif event.scancode == KEY_2 and decision_time:
			decision_time = false
			dialog = PATH2
			page = 0
			set_bbcode(dialog[page])
			set_visible_characters(0)
			
	
func _on_Timer_timeout():
	# every 0.05 seconds, display a new character
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		if page == dialog.size()-1 and dialog == initial:
			decision_time = true