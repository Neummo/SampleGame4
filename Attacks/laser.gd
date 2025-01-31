extends Ray
class_name Laser

@export var aoe: Area2D
@export var aoe_shape: CollisionShape2D
@export var range_indicator: Line2D
@export var line: Line2D
@export var casting_particles: GPUParticles2D
@export var collision_particles: GPUParticles2D
@export var beam_particles: GPUParticles2D
var is_casting: bool = false
var closest_enemy: Area2D
var last_collision_location: Vector2
var damaged: bool = false
var is_aoe: bool = false
var gun_name: String = "Laser"
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	set_physics_process(false)
	line.points[1] = Vector2.ZERO
	aoe_shape.get_shape().set_radius(Values.ult_gun_aoe_radius)

func _physics_process(_delta: float) -> void:
	if is_instance_valid(closest_enemy):
		rotation = player.body.global_position.direction_to(closest_enemy.global_position).angle()
		last_collision_location = to_local(closest_enemy.global_position)
	var cast_point: Vector2 = target_position
	force_raycast_update()
	collision_particles.emitting = is_colliding() and is_casting
	if is_colliding():
		var collider: Area2D = get_collider()
		if not damaged and is_instance_valid(collider) and collider is HitboxComponent and not collider.owner.dying:
			if is_aoe:
				aoe_damage(collider.global_position)
			else:
				var attack: Attack = Attack.new()
				attack.attack_type = "Energy"
				attack.attack_damage = damage
				collider.damage(attack)
			damaged = true
			cast_point = to_local(get_collision_point())
			collision_particles.global_rotation = get_collision_normal().angle()
			collision_particles.position = cast_point
	
	cast_point = last_collision_location
	target_position = cast_point
	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func aoe_damage(impact_position: Vector2):
	range_indicator.spawn_position = aoe_shape.global_position
	range_indicator.radius = Values.ult_gun_aoe_radius
	range_indicator.width = 3.0
	range_indicator.draw_range_indicator()
	var tween = create_tween()
	tween.tween_property(range_indicator, "width", 0, clampf(Values.player_ult_gun_cooldown, 0.1, 0.3))
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
		if area is HitboxComponent and area.possesor == "Enemy":
			var attack: Attack = Attack.new()
			attack.attack_damage = damage
			attack.attack_type = "Energy"
			area.damage(attack)

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles.emitting = false
		disappear()
	
func appear() -> void:
	set_physics_process(true)
	var tween = create_tween()
	tween.tween_property(line, "width", 10.0, 0.1)
	await tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, clampf(Values.player_ult_gun_cooldown, 0.1, 0.2))
	await tween.finished
	set_physics_process(false)
	damaged = false
