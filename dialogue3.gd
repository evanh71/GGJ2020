extends RichTextLabel

export var dialog = ['I knew I would run into one of you, I just thought it would be sooner.','Usually your kind is crawling all over the place.','Gimme your eyes.', '[ Can I give you one? ]', 'No way! I want both!', 'I would never be caught dead walking around with one eye!', '[ Press 1 to give them your eyes, Press 2 to refuse. ]']
var initial = dialog
export var PATH1 = ['Well, at least you are good for something...','Geez, you sure are quite the sore sight.',"You better hurry up and get going, there's no way I'll wait around for someone like you.", 'Really, what good is someone with no eyes?']
export var PATH2 = ['WHAT?','WHAT KIND OF NERVE IS THAT?','IF I HAD ANY IDEA WHERE YOU WERE, I WOULD TAKE THEM MYSELF']
var page = 0
var decision_time = false
var leave_time = false
var dia_noises = ['peeper 1  ', 'peeper 2', 'peeper 3', 'peeper 4']
var dia_noise = dia_noises[0]
var i = 0

signal black
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
				get_tree().change_scene('res://credits.tscn')
			else:
				get_tree().change_scene('res://L3S1A.tscn')
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
			emit_signal('black')
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
	if get_visible_characters() < get_total_character_count() and not sound.get_node(dia_noise).is_playing():
		sound.get_node(dia_noise).play()
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		sound.get_node(dia_noise).stop()
		i += 1
		dia_noise = dia_noises[i%4]
	if get_visible_characters() > get_total_character_count() and page == dialog.size()-1 :
		if dialog == initial:
			decision_time = true
		elif dialog == PATH1 or dialog == PATH2:
				leave_time = true
