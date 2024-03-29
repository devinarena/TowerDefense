extends Particles2D

var start = Color(1, 0, 0, 1)
var end = Color(0, 0, 0, 0)

func _ready():
	one_shot = true
	process_material = get_process_material().duplicate(true)
	
func set_colors(start, end):
	self.start = start
	self.end = end
	get_process_material().get_color_ramp().gradient.colors[0] = start
	get_process_material().get_color_ramp().gradient.colors[1] = end

func _process(delta):
	if !emitting:
		queue_free()