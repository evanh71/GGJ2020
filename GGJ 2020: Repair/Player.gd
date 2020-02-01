extends KinematicBody2D
# this script contols movement
const UP = Vector2(0,-1)
var motion = Vector2() # vector is direction + velocity
export var max_speed = 300
export var acceleration = 75
export var gravity = 40
export var jump_force = -800
export var legs = true
export var ears = true
export var eyes = true

func _physics_process(delta):
	# runs @ fps, check for presses and apply motion
	if not legs:
		max_speed = 200
		jump_force = -600
	var friction = false
	motion.y += gravity
	if Input.is_action_pressed('ui_right'):
		motion.x = min(motion.x+acceleration,max_speed) # speed cap
	elif Input.is_action_pressed('ui_left'):
		motion.x = max(motion.x-acceleration,-max_speed) # speed cap
	else:
		friction = true
	if Input.is_action_pressed('ui_accept'):
		legs = false
		print('legs set off')
	if is_on_floor():
		if Input.is_action_just_pressed('ui_up'):
			motion.y = jump_force
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2) # initial speed, approaching 0, 20% decay
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1) # and in air
	motion = move_and_slide(motion,UP)