extends Projectile
class_name RocketHoming

@export var aoe: Area2D
@export var aoe_shape: CollisionShape2D
@export var range_indicator: Line2D
@export var gun_range_indicator: Area2D
@export var sprite: Sprite2D
var steer_force: float = 200
var acceleration: Vector2 = Vector2.ZERO
var closest_enemy: Area2D
var player: CharacterBody2D
var is_aoe: bool = false
var tween: Tween
var start_seeking: bool = false
@onready var timer: Timer = $Timer

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	target = "Enemy"
	damage = Values.player_manual_gun_damage
	speed = Values.player_manual_gun_speed
	aoe_shape.get_shape().set_radius(Values.player_manual_aoe_area)
	global_position = spawn_position
	global_rotation = spawn_rotation
	timer.start()

func _physics_process(_delta):
	if closest_enemy == null:
		closest_enemy = get_closest_enemy()
	acceleration += seek()
	velocity += acceleration * _delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle() + 1.57079633
	move_and_slide()

func get_closest_enemy() -> Area2D:
	var overlapping_areas: Array[Area2D] = gun_range_indicator.get_overlapping_areas()
	var min_distance: float
	closest_enemy = null
	for area in overlapping_areas:
		if area is HitboxComponent and area.possesor != "Player" and not area.owner.dying:
			var distance_to_enemy: float = global_position.distance_squared_to(area.global_position)
			if not closest_enemy:
				min_distance = global_position.distance_squared_to(area.global_position)
				closest_enemy = area
			if distance_to_enemy < min_distance:
				min_distance = distance_to_enemy
				closest_enemy = area
	return closest_enemy

func seek():
	var steer: Vector2 = Vector2(0, -speed).rotated(spawn_rotation)
	if is_instance_valid(closest_enemy) and not closest_enemy.owner.dying and start_seeking:
		var desired = (closest_enemy.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func aoe_damage(impact_position: Vector2):
	range_indicator.spawn_position = aoe_shape.global_position
	range_indicator.radius = Values.player_manual_aoe_area
	range_indicator.width = 2.0
	range_indicator.draw_range_indicator()
	tween = create_tween()
	tween.tween_property(range_indicator, "width", 0, 0.2)
	
	aoe.global_position = impact_position
	var physics_params: PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	var physics_space_state: PhysicsDirectSpaceState2D
	physics_space_state = get_world_2d().direct_space_state

	physics_params.set_shape(aoe_shape.get_shape()) 
	physics_params.set_transform(aoe_shape.global_transform)
	physics_params.set_collision_mask(1)
	physics_params.set_collide_with_bodies(false)
	physics_params.set_collide_with_areas(true)
	var query_results = physics_space_state.intersect_shape(physics_params)
	for result in query_results:
		var area = result.collider
		if is_instance_valid(area) and not area.owner.dying and area is HitboxComponent and area.possesor == "Enemy":
			var attack: Attack = Attack.new()
			attack.attack_damage = damage
			area.damage(attack)

func _on_timer_timeout() -> void:
	start_seeking = true
