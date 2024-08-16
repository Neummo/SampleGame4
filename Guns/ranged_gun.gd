extends Gun
class_name RangedGun

@export var homing: bool = false
@export var gun_timer: Timer
var gun_switch: bool = true

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	update_stats()

func update_stats() -> void:
	gun_timer.set_wait_time(Values.player_manual_gun_cooldown)
	homing = Values.manual_gun_homing

func shoot():
	if !gun_switch or !cooldown_passed:
		return
	if homing:
		spawn_homing_projectile()
	else:
		spawn_projectile()

func spawn_projectile():
	cooldown_passed = false
	var projectile = load("res://Attacks/rocket.tscn")
	var instance = projectile.instantiate()
	var angle = player.global_position.direction_to(player.get_global_mouse_position()).angle() + 1.57079633
	instance.target = "Enemy"
	instance.spawn_position = player.global_position + Vector2(0, -5).rotated(angle)
	instance.spawn_rotation = player.body.global_position.direction_to(player.closest_enemy.global_position).angle()  + 1.57079633
	get_tree().current_scene.add_child.call_deferred(instance)
	gun_timer.start()

func spawn_homing_projectile():
	cooldown_passed = false
	var projectile = load("res://Attacks/rocket_homing.tscn")
	var instance = projectile.instantiate()
	var angle = player.global_position.direction_to(player.get_global_mouse_position()).angle() + 1.57079633
	instance.target = "Enemy"
	instance.spawn_position = player.global_position + Vector2(0, -5).rotated(angle)
	instance.spawn_rotation = angle
	get_tree().current_scene.add_child.call_deferred(instance)
	gun_timer.start()

func toggle_gun():
	gun_switch = !gun_switch

func _on_gun_timer_timeout():
	cooldown_passed = true
