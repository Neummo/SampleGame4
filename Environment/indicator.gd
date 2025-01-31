extends Sprite2D

@onready var asteroid: CharacterBody2D
var radius: int = 25

func _physics_process(delta: float) -> void:
	if not is_instance_valid(asteroid):
		queue_free()
		return
	var angle: float = get_parent().global_position.direction_to(asteroid.global_position).angle()
	position = point_on_circle(angle)
	rotation = angle

func point_on_circle(angle: float) -> Vector2:
	var s: float = cos(angle)
	var c: float = sin(angle)
	var point: Vector2 = Vector2(s * radius, c * radius)
	return point
