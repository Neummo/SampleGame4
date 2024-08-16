extends CharacterBody2D
class_name Enemy

@export var health_component: HealthComponent
@export var stats: EnemyStats
@export var health_bar: ProgressBar
@export var body: Node2D

var player: CharacterBody2D

func despawn() -> void:
	if get_player_distance() > 5000:
		queue_free()

func rotate_to_target(target, delta):
	pass

func run(_delta: float) -> void:
	var dir = (player.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(-angle_to) * min(_delta * 2, abs(angle_to)))
	var vector: Vector2 = Vector2(stats.acceleration * 3, 0)
	velocity += (vector.rotated(body.rotation)).normalized() * _delta * stats.acceleration * 2

func get_player_distance() -> float:
	return snapped(global_position.distance_to(player.global_position), 1)

func behavior(delta: float) -> void:
	pass
