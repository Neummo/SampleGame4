extends Enemy

var rotation_speed: float = 0.5
	
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	stats.set_stats({
		"acceleration": Values.enemy_acceleration * 4,
		"max_speed": randf_range(Values.enemy_speed * 2 - 50, Values.enemy_speed * 2),
		"max_health": int(floor(Values.enemy_health / 2))
	})
	health_component.health = stats.max_health
	health_component.value = 2
	health_bar.init_health(stats.max_health)
	timer.wait_time = Values.dot_tick_time

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(angle_to) * min(delta * rotation_speed, abs(angle_to)))
	
func behavior(delta: float) -> void:
	velocity += (Vector2(stats.acceleration, 0).rotated(body.rotation)).normalized() * delta * stats.acceleration
	velocity = velocity.limit_length(stats.max_speed)

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.possesor == "Player":
		var attack: Attack = Attack.new()
		attack.attack_damage = Values.enemy_damage * 3
		area.damage(attack)
		var self_destruck: Attack = Attack.new()
		self_destruck.attack_damage = stats.max_health
		health_component.damage(self_destruck)

func _on_timer_timeout() -> void:
	var damage = maxi(1, int(floor(dot_pool * 0.1)))
	dot_pool -= damage
	var attack: Attack = Attack.new()
	attack.attack_damage = damage
	health_component.damage(attack)
