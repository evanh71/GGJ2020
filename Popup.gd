extends AcceptDialog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var conversation_state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_text('give me ur got damn ear juice')
	add_button('No',true,"no")
	add_button('Yes',false,'yes')

func _on_ToolButton_pressed():
	popup_centered_ratio(0.25)

# when button is clicked!
func _on_Popup_custom_action(action):
	# if the conversation has not progressed 
	if action == 'no' and not conversation_state:
		set_text('fine then i guess me and my spider babies are done for')
	elif action == 'yes' and not conversation_state:
		set_text('yay thank you for the nourishment we will feast on your juice')
	conversation_state = 1
