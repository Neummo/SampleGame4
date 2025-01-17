extends Enemy
class_name Boss

var shooting: bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	stats.set_stats({
		"acceleration": Values.enemy_acceleration / 5,
		"max_speed": Values.enemy_speed / 5,
		"max_health": Values.enemy_health * 2 * Values.zone
	})
	health_component.value = 100
	health_component.health = stats.max_health
	health_bar.init_health(stats.max_health)
	shoot_timer.wait_time = maxf(0.5, shoot_timer.wait_time - (Values.zone / 5))
	body.rotation = body.transform.x.angle_to(player.global_position - global_position)
	timer.wait_time = Values.dot_tick_time

func shoot():
	for i in range(0, 3):
		var projectile = load("res://Attacks/enemy_rocket_homing.tscn")
		var instance = projectile.instantiate()
		instance.spawn_position = global_position + Vector2(5, 0).rotated(body.rotation)
		instance.spawn_rotation = body.rotation + randf_range(1.24, 1.9)
		get_tree().current_scene.add_child.call_deferred(instance)

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	if arrived:
		body.rotate(sign(angle_to) * delta * 0.1)
	else:
		body.look_at(player.global_position)

func behavior(delta: float) -> void:
	if global_position.distance_to(player.global_position) > Values.enemy_range * 10 and shooting:
		shooting = false
		shoot_timer.stop()
		arrived = false
	elif not shooting:
		shooting = true
		shoot_timer.start()
	if global_position.distance_to(player.global_position) <= Values.enemy_range:
		velocity += (Vector2(0, stats.acceleration).rotated(body.rotation)).normalized() * delta * stats.acceleration
	else:
		velocity += (Vector2(stats.acceleration, 0).rotated(body.rotation)).normalized() * delta * stats.acceleration
	velocity = velocity.limit_length(stats.max_speed)

func _physics_process(delta):
	move_and_slide()
	if Values.player_can_dot:
		tick_dot()
	if Values.zone == 0:
		run(delta)
		return
	if arrived:
		behavior(delta)
		rotate_to_target(player, delta)
	else:
		arrive(delta)
		body.look_at(player.global_position)

func _on_shoot_timer_timeout():
	shoot()

func _on_timer_timeout() -> void:
	var damage = maxi(1, int(floor(dot_pool * 0.1)))
	dot_pool -= damage
	var attack: Attack = Attack.new()
	attack.attack_damage = damage
	health_component.damage(attack)
