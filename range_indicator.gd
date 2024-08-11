extends Line2D

var radius: float
var spawn_position: Vector2

func indicate_out_of_range():
	default_color = Color8(255, 0, 0, 10)

func draw_range_indicator():
	global_position = spawn_position
	clear_points()
	for i in range(0, 361):
		var angle: float = deg_to_rad(1.0 * i)
		add_point(point_on_circle(angle))

func point_on_circle(angle: float) -> Vector2:
	var s: float = sin(angle)
	var c: float = cos(angle)
	var point: Vector2 = Vector2(s * radius, c * radius)
	return point
