extends Enemy
class_name Bounty4

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	stats.set_stats({
		"acceleration": Values.enemy_acceleration * 100,
		"max_speed": Values.enemy_speed * 2,
		"max_health": Values.enemy_health * 10 * (Values.zone + 1)
	})
	health_component.health = stats.max_health
	health_component.value = 1000
	health_bar.init_health(stats.max_health)
	body.rotation = body.transform.x.angle_to(player.global_position - global_position)
	timer.wait_time = Values.dot_tick_time

func _physics_process(delta):
	if Values.player_can_dot:
		tick_dot()
	move_and_slide()
	behavior(delta)
	rotate_to_target(player, delta)

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(angle_to) * delta * 1.5)

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		var attack: Attack = Attack.new()
		attack.attack_damage = Values.enemy_damage
		area.damage(attack)

func behavior(delta: float) -> void:
	if global_position.distance_to(player.global_position) <= Values.enemy_range * 5:
		velocity += (Vector2(stats.acceleration, 0).rotated(body.rotation)).normalized() * delta * stats.acceleration
	else:
		velocity = Vector2(0, 0)
	velocity = velocity.limit_length(stats.max_speed)

func _on_timer_timeout() -> void:
	var damage = maxi(1, int(floor(dot_pool * 0.1)))
	dot_pool -= damage
	var attack: Attack = Attack.new()
	attack.attack_damage = damage
	health_component.damage(attack)
