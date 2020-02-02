extends RichTextLabel

export var dialog = ["Sssssskss... you're one of those things...", 'You can survive anything...', 'My children and I will not survive without a way to navigate...', 'I need your ears... and your inner ear fluid...', 'Ssssksksk... well mostly the fluid...', "But what's one without the other, right?", '[ Press 1 to give her your ears, Press 2 to refuse. ]']
var initial = dialog
export var PATH1 = ['Thank you so much~', 'Thank you... sssssssksksksk', 'Wonder how many will make it to the ship...', 'See you there... maybe.']
export var PATH2 = ['What?!','Why?!','I need to get my children to safety...']
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
				get_tree().change_scene('res://S2L2ALE.tscn')
			else:
				get_tree().change_scene('res://S2L2AL.tscn')
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
			sound.get_node('part_loss').play()
			
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
