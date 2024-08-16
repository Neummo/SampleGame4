extends Gun
class_name MeleeGun

@export var gun_timer: Timer
var closest_enemy: Area2D
var gun_switch: bool = true

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	update_stats()

func update_stats() -> void:
	gun_timer.set_wait_time(Values.player_melee_gun_cooldown)

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
	var angle = player.global_position.direction_to(closest_enemy.global_position).angle() + 1.57079633
	instance.target = "Enemy"
	instance.spawn_position = player.global_position + Vector2(0, -5).rotated(angle)
	instance.spawn_rotation = angle
	get_tree().current_scene.add_child.call_deferred(instance)
	gun_timer.start()

func _on_gun_timer_timeout():
	cooldown_passed = true
