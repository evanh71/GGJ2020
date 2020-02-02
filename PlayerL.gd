extends KinematicBody2D

onready var sprite = get_node('Sprite')

const UP = Vector2(0,-1)
var motion = Vector2() # vector is direction + velocity
export var max_speed = 300
export var acceleration = 75
export var gravity = 40
export var jump_force = -800
export var legs = false
export var ears = true
export var eyes = true
onready var initial_pos = get_global_position()
var anim = "idle"

func _physics_process(delta):
	# runs @ fps, check for presses and apply motion
	if not legs:
		max_speed = 200
		jump_force = -600
	var friction = false
	motion.y += gravity
	if Input.is_action_pressed('ui_right') and ears:
		motion.x = min(motion.x+acceleration,max_speed) # speed cap
	elif Input.is_action_pressed('ui_left') and ears:
		motion.x = max(motion.x-acceleration,-max_speed) # speed cap
	# if ears are disabled, reverse the controls
	elif Input.is_action_pressed('ui_right') and not ears:
		motion.x = max(motion.x-acceleration,-max_speed)
	elif Input.is_action_pressed('ui_left') and not ears:
		motion.x = min(motion.x+acceleration,max_speed)
	else:
		friction = true
	if is_on_floor():
		if Input.is_action_just_pressed('ui_up'):
			motion.y = jump_force
			sound.get_node('jump').play(0.15)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2) # initial speed, approaching 0, 20% decay
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1) # and in air
	motion = move_and_slide(motion,UP)
	
	# set animation
	if motion.y == 0 and anim == 'fall':
		if is_on_floor():
			anim = 'fallend'
			sound.get_node('land').play()
	elif motion.y == 0 and anim == 'jump':
			anim = 'fall'
	elif motion.y > 0:
		anim = 'jump'
	elif motion.y < 0 or motion.y == 0 and anim == 'jump':
		anim = 'fall'
	elif abs(motion.x) > 20:
		anim = 'running'
	else:
		anim = 'idle'
	if motion.x > 0:
		sprite.set_flip_h(false)
	elif motion.x < 0:
		sprite.set_flip_h(true)
	sprite.play(anim)
	
	# failsafe for falling
	if get_global_position()[1] > 1000:
		set_global_position(initial_pos)

func _on_Area2D_body_entered(body):
	sound.get_node('death').play()
	set_global_position(initial_pos)

