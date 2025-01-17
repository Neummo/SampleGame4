extends Enemy

@onready var directions: Array

var rotation_speed: float = 1
var shooting: bool = false
var direction: int

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	stats.set_stats({
		"acceleration": Values.enemy_acceleration / 2,
		"max_speed": Values.enemy_speed * 2,
		"max_health": Values.enemy_health * 3
	})
	health_component.value = 8
	health_component.health = stats.max_health
	health_bar.init_health(stats.max_health)
	directions = [-stats.acceleration, stats.acceleration]
	direction = directions[randi() % directions.size()]
	shoot_timer.wait_time = maxf(1, shoot_timer.wait_time - (Values.zone * 0.02))
	timer.wait_time = Values.dot_tick_time

func shoot():
	var projectile = load("res://Attacks/enemy_rocket_homing.tscn")
	var instance = projectile.instantiate()
	instance.spawn_position = global_position + Vector2(5, 0).rotated(body.rotation)
	instance.spawn_rotation = body.rotation + 1.57079633
	get_tree().current_scene.add_child.call_deferred(instance)

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(angle_to) * min(delta * rotation_speed, abs(angle_to)))
	
func behavior(delta: float) -> void:
	if abs(body.get_angle_to(player.global_position)) >= 0.17:
		if shooting:
			shooting = false
			shoot_timer.stop()
		velocity -= (Vector2(velocity.x, velocity.y) * delta)
	else:
		if global_position.distance_to(player.global_position) > Values.enemy_range * randf_range(1.3, 1.8) and shooting:
			shooting = false
			shoot_timer.stop()
		elif not shooting:
			shooting = true
			shoot_timer.start()
		if global_position.distance_to(player.global_position) <= Values.enemy_range * randf_range(1.3, 1.8):
			velocity += (Vector2(0, direction).rotated(body.rotation)).normalized() * delta * stats.acceleration
		else:
			velocity += (Vector2(stats.acceleration, 0).rotated(body.rotation)).normalized() * delta * stats.acceleration
	velocity = velocity.limit_length(stats.max_speed)
	
func _on_shoot_timer_timeout():
	direction = directions[randi() % directions.size()]
	shoot()


func _on_timer_timeout() -> void:
	var damage = maxi(1, int(floor(dot_pool * 0.1)))
	dot_pool -= damage
	var attack: Attack = Attack.new()
	attack.attack_damage = damage
	health_component.damage(attack)
