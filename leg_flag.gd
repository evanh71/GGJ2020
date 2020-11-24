extends Label


var legs = true
var ears = true

func get_legs():
	return legs
func set_legs():
	legs = false
func get_ears():
	return ears
func set_ears():
	ears = false
func get_sprite():
	if legs:
		return get_node('leg_sprite')
	else:
		return get_node('no_leg_sprite')
