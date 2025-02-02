extends Enemy
class_name Bounty3

@export var laser_timer: Timer
@onready var directions: Array

var shooting: bool = false
var direction: int

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	stats.set_stats({
		"acceleration": Values.enemy_acceleration * 5,
		"max_speed": Values.enemy_speed / 2,
		"max_health": Values.enemy_health * 20 * (Values.zone + 1)
	})
	health_component.health = stats.max_health
	health_component.value = 1000
	health_bar.init_health(stats.max_health)
	body.rotation = body.transform.x.angle_to(player.global_position - global_position)
	directions = [-stats.acceleration, stats.acceleration]
	direction = directions[randi() % directions.size()]
	timer.wait_time = Values.dot_tick_time

func _physics_process(delta):
	if Values.player_can_dot:
		tick_dot()
	move_and_slide()
	behavior(delta)
	rotate_to_target(player, delta)

func laser() -> void:
	var projectile = load("res://Attacks/enemy_laser_projectile.tscn")
	var instance = projectile.instantiate()
	instance.spawn_position = global_position + Vector2(5, 0).rotated(body.rotation)
	instance.spawn_rotation = body.rotation + 1.57079633
	get_tree().current_scene.add_child.call_deferred(instance)

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(angle_to) * delta * 1)

func behavior(delta: float) -> void:
	if global_position.distance_to(player.global_position) > Values.enemy_range and shooting:
		shooting = false
		laser_timer.stop()
	elif not shooting:
		shooting = true
		laser_timer.start()
	if global_position.distance_to(player.global_position) <= Values.enemy_range:
		velocity += (Vector2(0, direction).rotated(body.rotation)).normalized() * delta * stats.acceleration
	else:
		velocity = Vector2(0, 0)
	velocity = velocity.limit_length(stats.max_speed)

func _on_laser_timer_timeout() -> void:
	laser()

func _on_timer_timeout() -> void:
	var damage = maxi(1, int(floor(dot_pool * 0.1)))
	dot_pool -= damage
	var attack: Attack = Attack.new()
	attack.attack_damage = damage
	health_component.damage(attack)
