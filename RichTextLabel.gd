extends RichTextLabel

export var dialog = ['Hey! Hey you!', 'Hey hey hey, You have a leg to spare?', "I am kinda stuck down here...", 'Whaddya say?!','You should be fine without it. You only need one after all...','Hey, come on, help a buddy out!', '[ Press 1 to give him your leg, Press 2 to refuse. ]']
var initial = dialog
export var PATH1 = ['Hey hey, thanks!',"You're a real one.",'I really owe you!',"Let's meetup at the evacuation ship later."]
export var PATH2 = ["Hey hey, don't feel bad.", 'Gotta do what you gotta do, right?', 'You better get going, someone else will come along for me!']
var page = 0
var decision_time = false
var leave_time = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event):
	# handles the input from the player
	
	if event is InputEventKey and event.pressed:
		# if the space bar is pressed, advance the text at the end of the message
		if leave_time:
			if dialog == PATH1:
				get_tree().change_scene('res://Screen2Level1afterleg.tscn')
			else:
				get_tree().change_scene('res://Screen2Level1after.tscn')
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
	if get_visible_characters() > get_total_character_count() and page == dialog.size()-1 :
		if dialog == initial:
			decision_time = true
		elif dialog == PATH1 or dialog == PATH2:
				leave_time = true
			
				