extends Projectile
class_name RocketHoming

@export var gun_range_indicator: Area2D
var steer_force: float = 200
var acceleration: Vector2 = Vector2.ZERO
var closest_enemy: Area2D
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	target = "Enemy"
	damage = Values.player_manual_gun_damage
	speed = Values.player_manual_gun_speed
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(_delta):
	if closest_enemy == null:
		get_closest_enemy()
	acceleration += seek()
	velocity += acceleration * _delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle() + 1.57079633
	move_and_slide()

func seek():
	var steer: Vector2 = Vector2(0, -speed).rotated(spawn_rotation)
	if closest_enemy:
		var desired = (closest_enemy.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

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
