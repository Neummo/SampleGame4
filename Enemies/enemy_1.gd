extends Enemy

var rotation_speed: float = 50

func _ready():
	stats.set_stats({
		"acceleration": Values.enemy_acceleration * 2,
		"max_speed": Values.enemy_speed * 2,
		"max_health": Values.enemy_health / 2
	})
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	health_component.health = stats.max_health
	health_bar.init_health(stats.max_health) 

func _physics_process(delta):
	despawn()
	move_and_slide()
	if Values.safe_zone:
		run(delta)
		return
	rotate_to_target(player, delta)
	behavior(delta)

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
		attack.attack_damage = stats.max_health
		health_component.damage(attack)
