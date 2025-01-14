extends Gun
class_name MeleeGun

@export var gun_timer: Timer
var closest_enemy: Area2D
var gun_switch: bool = true
var homing: bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	update_stats()

func update_stats() -> void:
	gun_timer.set_wait_time(Values.player_melee_gun_cooldown / Values.attack_speed_modifier)
	homing = Values.melee_gun_homing

func shoot():
	if !gun_switch or !cooldown_passed:
		return
	closest_enemy = player.closest_enemy
	if closest_enemy != null:
		spawn_projectile()

func toggle_gun():
	gun_switch = !gun_switch

func spawn_projectile():
	cooldown_passed = false
	var projectile = load("res://Attacks/laser_projectile.tscn")
	var instance = projectile.instantiate()
	var angle = global_position.direction_to(closest_enemy.global_position).angle() + 1.57079633
	instance.target = "Enemy"
	instance.spawn_position = global_position + Vector2(0, 0).rotated(angle)
	instance.spawn_rotation = angle
	instance.homing = homing
	instance.closest_enemy = player.closest_enemy
	get_tree().current_scene.add_child.call_deferred(instance)
	gun_timer.start()

func _on_gun_timer_timeout():
	cooldown_passed = true
