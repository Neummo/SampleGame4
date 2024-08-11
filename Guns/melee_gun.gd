extends Gun
class_name MeleeGun

@export var gun_timer: Timer
@export var gun_range_indicator: Area2D
@export var gun_range_shape: CollisionShape2D

var gun_range: float
var closest_enemy: Area2D
var gun_switch: bool = true

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	update_stats()

func update_stats() -> void:
	gun_timer.set_wait_time(Values.player_melee_gun_cooldown)
	gun_range = Values.player_melee_gun_range
	gun_range_shape.shape.set_radius(gun_range)

func shoot():
	if !gun_switch or !cooldown_passed:
		return
	closest_enemy = get_closest_enemy()
	if closest_enemy != null and player.global_position.distance_to(closest_enemy.global_position) <= gun_range:
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

func get_closest_enemy() -> Area2D:
	var overlapping_areas: Array[Area2D] = gun_range_indicator.get_overlapping_areas()
	var min_distance: float
	closest_enemy = null
	for area in overlapping_areas:
		if area is HitboxComponent and area.possesor != "Player":
			var distance_to_enemy: float = player.global_position.distance_squared_to(area.global_position)
			if not closest_enemy:
				min_distance = player.global_position.distance_squared_to(area.global_position)
				closest_enemy = area
			if distance_to_enemy < min_distance:
				min_distance = distance_to_enemy
				closest_enemy = area
	
	return closest_enemy

func _on_gun_timer_timeout():
	cooldown_passed = true
